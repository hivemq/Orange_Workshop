-- mqtt client tables
create table users
(
    id                  serial      not null
        constraint users_pkey primary key,
    username            text        not null
        constraint users_username_unique unique,
    password            text,
    password_iterations integer     not null,
    password_salt       text        not null,
    algorithm           varchar(32) not null,
    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now()
)
;

create unique index users_id_uindex
    on users (id)
;

create unique index users_username_uindex
    on users (username)
;

comment on column users.password is 'Base64 encoded raw byte array'
;

comment on column users.password_salt is 'Base64 encoded raw byte array'
;

create table roles
(
    id          serial      not null
        constraint roles_pkey primary key,
    name        text        not null
        constraint roles_name_unique unique,
    description text,
    created_at  timestamptz not null default now(),
    updated_at  timestamptz not null default now()
)
;

create unique index roles_id_uindex
    on roles (id)
;

create unique index roles_name_uindex
    on roles (name)
;

create table user_roles
(
    user_id    integer     not null
        constraint user_roles_users_id_fk references users,
    role_id    integer     not null
        constraint user_roles_roles_id_fk references roles,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint user_roles_user_role_pk
        primary key (user_id, role_id)
)
;

create table permissions
(
    id                    serial                not null
        constraint permissions_pkey primary key,
    topic                 text                  not null,
    publish_allowed       boolean default false not null,
    subscribe_allowed     boolean default false not null,
    qos_0_allowed         boolean default false not null,
    qos_1_allowed         boolean default false not null,
    qos_2_allowed         boolean default false not null,
    retained_msgs_allowed boolean default false not null,
    shared_sub_allowed    boolean default false not null,
    shared_group          text,
    created_at            timestamptz           not null default now(),
    updated_at            timestamptz           not null default now()
)
;

create index permissions_topic_index
    on permissions (topic)
;

comment on table permissions is 'All permissions are whitelist permissions'
;

create table role_permissions
(
    role       integer     not null
        constraint role_permissions_roles_id_fk references roles,
    permission integer     not null
        constraint role_permissions_permissions_id_fk references permissions,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint role_permissions_role_permission_pk
        primary key (role, permission)
)
;

create table user_permissions
(
    user_id    integer     not null
        constraint user_permissions_users_id_fk references users,
    permission integer     not null
        constraint user_permissions_permissions_id_fk references permissions,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint user_permissions_user_permission_pk
        primary key (user_id, permission)
)
;

-- control center tables
create table cc_users
(
    id                  serial      not null
        constraint cc_users_pkey primary key,
    username            text        not null
        constraint cc_users_username_unique unique,
    password            text,
    password_iterations integer     not null,
    password_salt       text        not null,
    algorithm           varchar(32) not null,
    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now()
)
;

create unique index cc_users_id_uindex
    on cc_users (id)
;

create unique index cc_users_username_uindex
    on cc_users (username)
;

comment on column cc_users.password is 'Base64 encoded raw byte array'
;

comment on column cc_users.password_salt is 'Base64 encoded raw byte array'
;

create table cc_roles
(
    id          serial      not null
        constraint cc_roles_pkey primary key,
    name        text        not null
        constraint cc_roles_name_unique unique,
    description text,
    created_at  timestamptz not null default now(),
    updated_at  timestamptz not null default now()
)
;

create unique index cc_roles_id_uindex
    on cc_roles (id)
;

create unique index cc_roles_name_uindex
    on cc_roles (name)
;

create table cc_user_roles
(
    user_id    integer     not null
        constraint cc_user_roles_users_id_fk references cc_users,
    role_id    integer     not null
        constraint cc_user_roles_roles_id_fk references cc_roles,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint cc_user_roles_user_role_pk
        primary key (user_id, role_id)
)
;

create table cc_permissions
(
    id                serial      not null
        constraint cc_permissions_pkey primary key,
    permission_string text        not null,
    description       text,
    created_at        timestamptz not null default now(),
    updated_at        timestamptz not null default now()
)
;

create table cc_role_permissions
(
    role       integer     not null
        constraint cc_role_permissions_roles_id_fk references cc_roles,
    permission integer     not null
        constraint cc_role_permissions_permissions_id_fk references cc_permissions,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint cc_role_permissions_role_permission_pk
        primary key (role, permission)
)
;

create table cc_user_permissions
(
    user_id    integer     not null
        constraint cc_user_permissions_users_id_fk references cc_users,
    permission integer     not null
        constraint cc_user_permissions_permissions_id_fk references cc_permissions,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint cc_user_permissions_user_permission_pk
        primary key (user_id, permission)
)
;

-- rest api tables
create table rest_api_users
(
    id                  serial      not null
        constraint rest_api_users_pkey primary key,
    username            text        not null
        constraint rest_api_users_username_unique unique,
    password            text,
    password_iterations integer     not null,
    password_salt       text        not null,
    algorithm           varchar(32) not null,
    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now()
)
;

create unique index rest_api_users_id_uindex
    on rest_api_users (id)
;

create unique index rest_api_users_username_uindex
    on rest_api_users (username)
;

comment on column rest_api_users.password is 'Base64 encoded raw byte array'
;

comment on column rest_api_users.password_salt is 'Base64 encoded raw byte array'
;

create table rest_api_roles
(
    id          serial      not null
        constraint rest_api_roles_pkey primary key,
    name        text        not null
        constraint rest_api_roles_name_unique unique,
    description text,
    created_at  timestamptz not null default now(),
    updated_at  timestamptz not null default now()
)
;

create unique index rest_api_roles_id_uindex
    on rest_api_roles (id)
;

create unique index rest_api_roles_name_uindex
    on rest_api_roles (name)
;

create table rest_api_user_roles
(
    user_id    integer     not null
        constraint rest_api_user_roles_users_id_fk references rest_api_users,
    role_id    integer     not null
        constraint rest_api_user_roles_roles_id_fk references rest_api_roles,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint rest_api_user_roles_user_role_pk
        primary key (user_id, role_id)
)
;

create table rest_api_permissions
(
    id                serial      not null
        constraint rest_api_permissions_pkey primary key,
    permission_string text        not null,
    description       text,
    created_at        timestamptz not null default now(),
    updated_at        timestamptz not null default now()
)
;

create table rest_api_role_permissions
(
    role       integer     not null
        constraint rest_api_role_permissions_roles_id_fk references rest_api_roles,
    permission integer     not null
        constraint rest_api_role_permissions_permissions_id_fk references rest_api_permissions,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint rest_api_role_permissions_role_permission_pk
        primary key (role, permission)
)
;

create table rest_api_user_permissions
(
    user_id    integer     not null
        constraint rest_api_user_permissions_users_id_fk references rest_api_users,
    permission integer     not null
        constraint rest_api_user_permissions_permissions_id_fk references rest_api_permissions,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint rest_api_user_permissions_user_permission_pk
        primary key (user_id, permission)
)
;

-- functions
create or replace function trigger_set_timestamp()
    returns trigger as
'
    begin
        new.updated_at = now();
        return new;
    end;
' language plpgsql;

-- triggers
-- mqtt triggers
create trigger users_updated_at_trigger
    before update
    on users
    for each row
execute procedure trigger_set_timestamp();

create trigger roles_updated_at_trigger
    before update
    on roles
    for each row
execute procedure trigger_set_timestamp();

create trigger user_roles_updated_at_trigger
    before update
    on user_roles
    for each row
execute procedure trigger_set_timestamp();

create trigger permissions_updated_at_trigger
    before update
    on permissions
    for each row
execute procedure trigger_set_timestamp();

create trigger user_permissions_updated_at_trigger
    before update
    on user_permissions
    for each row
execute procedure trigger_set_timestamp();

create trigger role_permissions_updated_at_trigger
    before update
    on role_permissions
    for each row
execute procedure trigger_set_timestamp();

-- control center triggers
create trigger cc_users_updated_at_trigger
    before update
    on cc_users
    for each row
execute procedure trigger_set_timestamp();

create trigger cc_roles_updated_at_trigger
    before update
    on cc_roles
    for each row
execute procedure trigger_set_timestamp();

create trigger cc_user_roles_updated_at_trigger
    before update
    on cc_user_roles
    for each row
execute procedure trigger_set_timestamp();

create trigger cc_permissions_updated_at_trigger
    before update
    on cc_permissions
    for each row
execute procedure trigger_set_timestamp();

create trigger cc_user_permissions_updated_at_trigger
    before update
    on cc_user_permissions
    for each row
execute procedure trigger_set_timestamp();

create trigger cc_role_permissions_updated_at_trigger
    before update
    on cc_role_permissions
    for each row
execute procedure trigger_set_timestamp();

-- rest api triggers
create trigger rest_api_users_updated_at_trigger
    before update
    on rest_api_users
    for each row
execute procedure trigger_set_timestamp();

create trigger rest_api_roles_updated_at_trigger
    before update
    on rest_api_roles
    for each row
execute procedure trigger_set_timestamp();

create trigger rest_api_user_roles_updated_at_trigger
    before update
    on rest_api_user_roles
    for each row
execute procedure trigger_set_timestamp();

create trigger rest_api_permissions_updated_at_trigger
    before update
    on rest_api_permissions
    for each row
execute procedure trigger_set_timestamp();

create trigger rest_api_user_permissions_updated_at_trigger
    before update
    on rest_api_user_permissions
    for each row
execute procedure trigger_set_timestamp();

create trigger rest_api_role_permissions_updated_at_trigger
    before update
    on cc_role_permissions
    for each row
execute procedure trigger_set_timestamp();


/* ################################################## Above is the standard table creation template ##################################################


   ##################################################    Below are the demo values for this course  ##################################################

The commands below fill your database with users, roles and permissions for following three clients:

Backendservice: Allows subscription to the topic/+/status topic filter and reception of all messages that match that topic filter. Publication of messages is not permitted.
Enables connection with the username = backendservice and password = backendpassword

Frontendclient: Allows publication of messages to the topic/${mqtt-clientid}/status topic. Subscriptions to the topic/${mqtt-clientid}/status topic is not permitted.
Enables connection with the username = frontendclient and password = clientpassword

Superuser: Allows everything. This user has no restrictions.
Enables connection with the username = superuser and password = supersecurepassword

*/


insert into public.users
  (username, password, password_iterations, password_salt, algorithm)
  values
    ('backendservice', 'wtUo2dri+ttHGHRpngg9uG21piWLiKSX7IaNSnU/BfN9pt+ZOLQByG/3JlPPQ7t/pl8S3tjR2+Um/DPBdAQULg==', 100, 'Nv6NU9XY7tvHdSGaKmNTOw==', 'SHA512'),
    ('frontendclient', 'ZHg/rNJel1BHOYMEvc40ekCRUE5vVLcsPF6mk9GPDcdEmX3stm50MplaqjGb8Lxhy6rNFQZSQRSbOxmFZ8ps1Q==', 100, 'JhpW27QU9WfIaG6FJT5MkQ==', 'SHA512'),
    ('superuser', 'nOgr9xVnkt51Lr68KS/rAKm/LqxAt8oEki7vCerRod3qDbyMFfDBGT8obnkw+AGygxCQDWdaA2sQnXXoAbVK6Q==', 100, 'wxw+3diCV4bWXQHb6LLniA==', 'SHA512');

insert into public.permissions
  (id, topic, publish_allowed, subscribe_allowed, qos_0_allowed, qos_1_allowed, qos_2_allowed, retained_msgs_allowed, shared_sub_allowed, shared_group)
  values
    (1, 'topic/+/status', false, true, true, true, true, false, false, ''),
    (2, 'topic/${mqtt-clientid}/status', true, false, true, true, true, true, false, ''),
    (3, '#', true, true, true, true, true, true, true, '');

insert into public.roles
  (id, name, description)
  values
    (1, 'backendservice', 'only allowed to subscribe to topics'),
    (2, 'frontendclients', 'only allowed to publish to topics'),
    (3, 'superuser', 'is allowed to do everything');

insert into public.user_roles
  (user_id, role_id)
  values
    (1, 1),
    (2, 2),
    (3, 3);

insert into public.role_permissions
  (role, permission)
  values
    (1, 1),
    (2, 2),
    (3, 3);

/*

   ##################################################    Below are the demo values for Control center  ##################################################

The commands below fill your database with users, roles and permissions for following three clients:

Superuser Role:
Username: superadmin / Password: password
Role: super_admin / Permission: Allowed to see and do everything in the HiveMQ Control Center.

Dashboard Viewer:
Username: dashboardviewer / Password: password
Role: dashboard_viewer / Permission: Allowed to see only the Dashboard page of the HiveMQ Control Center.

*/

insert into cc_roles (name, description)
values ('super_admin', 'has the HIVEMQ_SUPER_ADMIN permission'),
       ('dashboard_viewer', 'can only see the dashboard');

insert into public.cc_permissions (permission_string, description)
values ('HIVEMQ_SUPER_ADMIN', 'has the HIVEMQ_SUPER_ADMIN permission');

insert into cc_role_permissions (role, permission)
select cc_roles.id, cc_permissions.id
from cc_roles,
     cc_permissions
where cc_roles.name = 'super_admin'
  AND cc_permissions.permission_string = 'HIVEMQ_SUPER_ADMIN'
;


insert into cc_users (username, password, password_iterations, password_salt, algorithm)
values ('dashboardviewer', 'DR9yesp2mEBmNalk5uTj5byyOf5Cs/cz4zzbN8T/61UTwlMHa9isHqGmwiIMmcrcsnSs1YCct5X+ql9OmPnQdw==', 100, '6iWJ0lp4w2e/D0YyAyXw9w==', 'SHA512'),
       ('superadmin', 'TmjEM4X1i5+PiHBnQrjMHrLRw139o6FwZYrQrLXuzbPuuMOZ4qOl8pvkY5knxeahPqVAgC/fruVK/ZNa4TutvQ==', 100, 'lhtADCtQjVil1HDHwfnJ3Q==', 'SHA512');

INSERT INTO cc_user_roles (user_id, role_id)
select cc_users.id, cc_roles.id
from cc_users,
     cc_roles
where cc_users.username = 'dashboardviewer'
  AND cc_roles.name = 'dashboard_viewer'
;

INSERT INTO cc_user_roles (user_id, role_id)
select cc_users.id, cc_roles.id
from cc_users,
     cc_roles
where cc_users.username = 'superadmin'
  AND cc_roles.name = 'super_admin'
;