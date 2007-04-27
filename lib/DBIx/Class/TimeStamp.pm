package DBIx::Class::TimeStamp;

use base qw(DBIx::Class);

use warnings;
use strict;

use DateTime;

our $VERSION = '0.04';

__PACKAGE__->load_components( qw/InflateColumn::DateTime/ );
__PACKAGE__->mk_classdata( 
    '__column_timestamp_triggers' => {
        on_update => [], on_create => []
    }
);

=head1 NAME

DBIx::Class::TimeStamp

=head1 DESCRIPTION

Works in conjunction with InflateColumn::DateTime to automatically set update
and create date and time based fields in a table.

=head1 SYNOPSIS

 package My::Schema;

 __PACKAGE__->load_components(qw( TimeStamp ... Core ));
 
 __PACKAGE__->add_columns(
    id => { data_type => 'integer' },
    t_created => { data_type => 'datetime', set_on_create => 1 },
    t_updated => { data_type => 'datetime',
        set_on_create => 1, set_on_update => 1 },
 );

Now, any update or create actions will update the specified columns with the
current time, using the DateTime inflator.  

This is effectively trigger emulation to get consistent behavior across
databases that either implement them poorly or not at all.

=cut

sub add_columns {
    my $self = shift;

    # Add everything else, get everything setup, and then process
    $self->next::method(@_);
   
    my @update_columns = ();
    my @create_columns = ();

    foreach my $column ( $self->columns ) {
        my $info = $self->column_info($column);
        if ( $info->{data_type} =~ /^(datetime|date|timestamp)$/i ) {
            if ( $info->{set_on_update} ) {
                push @update_columns, $column;
            }
            if ( $info->{set_on_create} ) {
                push @create_columns, $column;
            }
        }
    }
    if ( @update_columns or @create_columns ) {
        my $triggers = {
            on_update => [ @update_columns ],
            on_create => [ @create_columns ],
        };
        $self->__column_timestamp_triggers($triggers);
    }
}

sub insert {
    my $self  = shift;
    my $attrs = shift;

    my $now  = $self->get_timestamp();

    my @columns = @{ $self->__column_timestamp_triggers()->{on_create} };

    foreach my $column ( @columns ) {
        next if defined $self->get_column( $column );
        $self->$column($now);
    }
    
    return $self->next::method(@_);
}

sub update {
    my $self = shift;

    my $now  = $self->get_timestamp();
    my %dirty = $self->get_dirty_columns();
    my @columns = @{ $self->__column_timestamp_triggers()->{on_update} };

    foreach my $column ( @columns ) {
        next if exists $dirty{ $column };
        $self->$column($now);
    }

    return $self->next::method(@_);
}

=head1 METHODS

=head2 get_timestamp

Returns a DateTime object pointing to now.  Override this method if you have
different time accounting functions, or want to do anything special.

The date and time objects in the database are expected to be inflated.  As such
you can be pretty flexible with what you want to return here.

=cut

sub get_timestamp {
    return DateTime->now
}

=head1 AUTHOR

J. Shirley <jshirley@gmail.com>

=head1 CONTRIBUTORS

LTJake

=head1 LICENSE

You may distribute this code under the same terms as Perl itself.

=cut

1;

