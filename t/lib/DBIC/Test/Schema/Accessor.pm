package #
    DBIC::Test::Schema::Accessor;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/TimeStamp PK::Auto Core/);
__PACKAGE__->table('test_accessor');

__PACKAGE__->add_columns(
    'pk1' => {
        data_type => 'integer', is_nullable => 0, is_auto_increment => 1
    },
    display_name => { data_type => 'varchar', size => 128, is_nullable => 0 },
    t_created => {
        data_type => 'datetime', is_nullable => 0,
        set_on_create => 1, accessor => 't_created_accessor',
    },
    t_updated => {
        data_type => 'datetime', is_nullable => 0,
        set_on_create => 1, set_on_update => 1, accessor => 't_updated_accessor',
    },
);

__PACKAGE__->set_primary_key('pk1');

no warnings 'redefine';

sub t_created {
    my $self = shift;
    croak('Shouldnt be trying to update through t_created - should use accessor') if shift;

    return $self->t_created_accessor();
}

sub t_updated {
    my $self = shift;
    croak('Shouldnt be trying to update through t_updated - should use accessor') if shift;

    return $self->t_updated_accessor();
}


1;
