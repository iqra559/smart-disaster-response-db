create database smart_disaster_db;
go

use smart_disaster_db;
go
create table disaster_type(
    disaster_type_id int identity(1,1) primary key,
    d_type_name varchar(50) not null unique,
    d_description varchar(200)
);
insert into disaster_type (d_type_name, d_description)
values
('Flood', 'Overflow of water in populated areas'),
('Earthquake', 'Sudden movement of the ground'),
('Cyclone', 'Severe rotating storm'),
('Fire', 'Large uncontrolled fire'),
('Landslide', 'Movement of rock or debris down a slope'),
('Drought', 'Prolonged shortage of water supply'),
('Tsunami', 'Large sea waves caused by underwater disturbance'),
('Heatwave', 'Extended period of excessive heat'),
('Volcanic Eruption', 'Sudden release of volcanic material'),
('Industrial Accident', 'Accident occurring at an industrial facility'),
('Building Collapse', 'Structural failure of a building'),
('Epidemic', 'Widespread outbreak of infectious disease'),
('Storm Surge', 'Abnormal rise of sea water during a storm'),
('Snowstorm', 'Heavy snowfall accompanied by strong winds');
create table location_tb(
    location_id int identity(1,1) primary key,
    city varchar(50) not null,
    area varchar(80) not null,
    constraint UQ_location unique(city, area)
);

insert into location_tb(city, area)
values
('Hyderabad', 'Latifabad'),
('Karachi', 'Malir'),
('Sukkur', 'Rohri'),
('Thatta', 'Makli'),
('Quetta', 'Sariab'),
('Karachi', 'Korangi'),
('Lahore', 'Model Town'),
('Islamabad', 'F-10'),
('Multan', 'Cantt'),
('Peshawar', 'Hayatabad'),
('Faisalabad', 'Jaranwala Road'),
('Larkana', 'Old City'),
('Gwadar', 'Port Area'),
('Skardu', 'City Center'),
('Muzaffarabad', 'Sector A');
create table disaster(
    disaster_id int identity(1,1) primary key,
    disaster_type_id int not null,
    location_id int not null,
    disaster_date date not null,
    severity varchar(20) not null,
    sstatus varchar(20) not null default 'Active',
    affected_people int not null default 0,
    foreign key (disaster_type_id) references disaster_type(disaster_type_id),
    foreign key (location_id) references location_tb(location_id),
    check (severity in ('Low','Medium','High','Critical')),
    check (sstatus in ('Active','Resolved')),
    check (affected_people >= 0)
);

insert into disaster
(disaster_type_id, location_id, disaster_date, severity, sstatus, affected_people)
values
(1, 1, '2026-07-15', 'High', 'Active', 5500),
(2, 5, '2026-06-20', 'Critical', 'Resolved', 8000),
(3, 4, '2026-08-01', 'High', 'Active', 3500),
(4, 2, '2026-07-28', 'Medium', 'Resolved', 1200),
(5, 6, '2026-08-10', 'Medium', 'Active', 900),
(6, 7, '2026-05-01', 'High', 'Active', 15000),
(7, 13, '2026-08-12', 'Critical', 'Active', 20000),
(8, 9, '2026-06-15', 'Medium', 'Resolved', 5000),
(1, 10, '2026-07-20', 'High', 'Active', 7000),
(2, 14, '2026-08-03', 'Critical', 'Active', 10000),
(9, 11, '2026-04-10', 'Low', 'Resolved', 300),
(10, 2, '2026-08-15', 'High', 'Active', 450),
(11, 7, '2026-07-01', 'Critical', 'Resolved', 600),
(12, 8, '2026-06-25', 'Medium', 'Active', 3000);
create index idx_Disaster_Status on disaster(sstatus);
select * from disaster where sstatus = 'Active';
create table rescue_team(
    team_id int identity(1,1) primary key,
    team_name varchar(80) not null unique,
    specialization varchar(80) not null,
    aavailability varchar(20) not null default 'Available',
    location_id int not null,
    foreign key (location_id) references location_tb(location_id),
    check (aavailability in ('Available','Assigned'))
);

insert into rescue_team
(team_name, specialization, aavailability, location_id)
values
('Alpha Team', 'Flood Rescue', 'Assigned', 1),
('Bravo Team', 'Medical Rescue', 'Available', 2),
('Delta Team', 'Earthquake Rescue', 'Assigned', 5),
('Coastal Team', 'Cyclone Rescue', 'Available', 4),
('Echo Team', 'Landslide Rescue', 'Available', 6),
('Foxtrot Team', 'Drought Relief', 'Available', 7),
('Tsunami Response Unit', 'Tsunami Rescue', 'Assigned', 13),
('Heat Relief Team', 'Heatwave Response', 'Available', 9),
('Urban Search Team', 'Building Collapse Rescue', 'Assigned', 7),
('Volcanic Response Team', 'Volcanic Rescue', 'Available', 11),
('Industrial Safety Team', 'Industrial Accident Response', 'Assigned', 2),
('Epidemic Control Team', 'Medical Rescue', 'Available', 8),
('Northern Rescue Squad', 'Earthquake Rescue', 'Assigned', 14),
('Highway Rescue Team', 'General Rescue', 'Available', 10);
create table hospital(
    hospital_id int identity(1,1) primary key,
    hospital_name varchar(100) not null,
    location_id int not null,
    total_beds int not null,
    available_beds int not null,
    foreign key (location_id) references location_tb(location_id),
    check (total_beds >= 0),
    check (available_beds >= 0),
    check (available_beds <= total_beds)
);

insert into hospital
(hospital_name, location_id, total_beds, available_beds)
values
('City Emergency Hospital', 1, 300, 80),
('Malir Medical Center', 2, 200, 60),
('Rohri General Hospital', 3, 150, 40),
('Quetta Trauma Hospital', 5, 400, 120),
('Korangi General Hospital', 6, 250, 90),
('Model Town Hospital', 7, 350, 150),
('F-10 Emergency Hospital', 8, 500, 200),
('Multan Cantt Hospital', 9, 220, 70),
('Hayatabad Medical Complex', 10, 400, 130),
('Jaranwala Road Hospital', 11, 180, 60),
('Larkana City Hospital', 12, 200, 80),
('Gwadar Port Hospital', 13, 150, 50),
('Skardu District Hospital', 14, 120, 40),
('Muzaffarabad General Hospital', 15, 260, 100);
create table relief_camp(
    camp_id int identity(1,1) primary key,
    camp_name varchar(100) not null unique,
    location_id int not null,
    capacity int not null,
    occupied int not null default 0,
    foreign key (location_id) references location_tb(location_id),
    check (capacity > 0),
    check (occupied >= 0),
    check (occupied <= capacity)
);

insert into relief_camp
(camp_name, location_id, capacity, occupied)
values
('Latifabad Relief Camp', 1, 1000, 700),
('Malir Relief Camp', 2, 800, 400),
('Rohri Relief Camp', 3, 600, 450),
('Makli Relief Camp', 4, 900, 650),
('Sariab Relief Camp', 5, 700, 300),
('Korangi Relief Camp', 6, 700, 300),
('Model Town Relief Camp', 7, 850, 400),
('F-10 Relief Camp', 8, 1000, 600),
('Multan Relief Camp', 9, 650, 350),
('Hayatabad Relief Camp', 10, 900, 500),
('Jaranwala Relief Camp', 11, 500, 200),
('Larkana Relief Camp', 12, 600, 300),
('Gwadar Relief Camp', 13, 750, 400),
('Skardu Relief Camp', 14, 400, 150),
('Muzaffarabad Relief Camp', 15, 800, 450);
create table Resources(
    resource_id int identity(1,1) primary key,
    resource_name varchar(80) not null,
    category varchar(50) not null,
    quantity int not null default 0,
    camp_id int not null,
    foreign key (camp_id) references relief_camp(camp_id),
    check (quantity >= 0)
);

insert into Resources
(resource_name, category, quantity, camp_id)
values
('Food Packs', 'Food', 1000, 1),
('Drinking Water', 'Essential', 3000, 1),
('Blankets', 'Shelter', 500, 1),
('Food Packs', 'Food', 800, 2),
('Drinking Water', 'Essential', 2500, 2),
('Medical Kits', 'Medical', 200, 3),
('Blankets', 'Shelter', 400, 3),
('Food Packs', 'Food', 1200, 4),
('Life Jackets', 'Rescue', 150, 4),
('Tents', 'Shelter', 300, 5),
('First Aid Kits', 'Medical', 500, 6),
('Drinking Water', 'Essential', 4000, 7),
('Food Packs', 'Food', 1500, 8),
('Cooking Gas Cylinders', 'Essential', 200, 9),
('Blankets', 'Shelter', 600, 10),
('Medical Kits', 'Medical', 250, 11),
('Life Jackets', 'Rescue', 100, 12),
('Flashlights', 'Essential', 350, 13),
('Portable Generators', 'Rescue', 40, 14);
create table disaster_team(
    disaster_id int not null,
    team_id int not null,
    assigned_date date not null default getdate(),
    primary key (disaster_id, team_id),
    foreign key (disaster_id) references disaster(disaster_id),
    foreign key (team_id) references rescue_team(team_id)
);

insert into disaster_team
(disaster_id, team_id, assigned_date)
values
(1, 1, '2026-07-15'),
(1, 2, '2026-07-15'),
(2, 3, '2026-06-20'),
(3, 4, '2026-08-01'),
(5, 5, '2026-08-10'),
(6, 6, '2026-05-01'),
(7, 7, '2026-08-12'),
(8, 8, '2026-06-15'),
(9, 1, '2026-07-20'),
(10, 13, '2026-08-03'),
(11, 10, '2026-04-10'),
(12, 11, '2026-08-15'),
(13, 9, '2026-07-01'),
(14, 12, '2026-06-25');
create table resource_Allocation(
    allocation_id int identity(1,1) primary key,
    disaster_id int not null,
    resource_id int not null,
    camp_id int not null,
    quantity_allocated int not null,
    allocation_date date not null default getdate(),
    foreign key (disaster_id) references disaster(disaster_id),
    foreign key (resource_id) references Resources(resource_id),
    foreign key (camp_id) references relief_camp(camp_id),
    check (quantity_allocated > 0)
);

insert into resource_Allocation
(disaster_id, resource_id, camp_id, quantity_allocated, allocation_date)
values
(1, 2, 1, 500, '2026-07-16'),
(3, 8, 4, 300, '2026-08-02'),
(2, 6, 3, 50, '2026-06-21'),
(1, 1, 1, 200, '2026-09-03'),
(5, 10, 5, 100, '2026-08-11'),
(6, 11, 6, 200, '2026-05-02'),
(7, 12, 7, 1000, '2026-08-13'),
(8, 15, 10, 150, '2026-06-16'),
(9, 13, 8, 500, '2026-07-21'),
(10, 16, 11, 80, '2026-08-04'),
(11, 14, 9, 60, '2026-04-11'),
(12, 18, 13, 120, '2026-08-16'),
(13, 17, 12, 40, '2026-07-02'),
(14, 19, 14, 10, '2026-06-26');
select * from disaster_type;
select * from location_tb;
select * from disaster;
select * from rescue_team;
select * from hospital;
select * from relief_camp;
select * from Resources;
select * from disaster_team;
select * from resource_Allocation;
select
    rc.camp_name,
    r.resource_name,
    r.category,
    r.quantity
from Resources r
inner join relief_camp rc on r.camp_id = rc.camp_id;

select
    d.disaster_id,
    dt.d_type_name as disaster_type,
    rc.camp_name,
    r.resource_name,
    ra.quantity_allocated,
    ra.allocation_date
from resource_Allocation ra
inner join disaster d on ra.disaster_id = d.disaster_id
inner join disaster_type dt on d.disaster_type_id = dt.disaster_type_id
inner join Resources r on ra.resource_id = r.resource_id
inner join relief_camp rc on ra.camp_id = rc.camp_id;
select
    l.city,
    l.area,
    d.disaster_id,
    d.severity
from location_tb l
left join disaster d
on l.location_id = d.location_id;

select count(*) as TotalDisasters from disaster;
select sum(affected_people) as TotalAffectedPeople from disaster;
select avg(affected_people) as AverageAffectedPeople from disaster;
select max(affected_people) as MaximumAffected from disaster;
select sstatus, count(*) as TotalDisasters from disaster group by sstatus;
select severity, count(*) as TotalDisasters from disaster group by severity;

begin transaction;

insert into resource_Allocation
(disaster_id, resource_id, camp_id, quantity_allocated, allocation_date)
values
(1, 3, 1, 100, getdate());

commit transaction;


select disaster_id, severity, sstatus, affected_people from disaster;
select * from disaster where sstatus = 'Active';

create procedure Get_Active_Disasters
as
begin
    select
        d.disaster_id,
        dt.d_type_name as disaster_type,
        l.city,
        l.area,
        d.disaster_date,
        d.severity,
        d.sstatus,
        d.affected_people
    from disaster d
    inner join disaster_type dt on d.disaster_type_id = dt.disaster_type_id
    inner join location_tb l on d.location_id = l.location_id
    where d.sstatus = 'Active';
end;
go

exec Get_Active_Disasters;

create trigger trg_DisasterStatus_Update
on disaster
after update
as
begin
    if update(sstatus)
    begin
        print 'Disaster status has been updated successfully.';
    end
end;
go

update disaster set sstatus = 'Resolved' where disaster_id = 1;
select 'disaster_type' as tbl, count(*) as total from disaster_type
union all select 'location_tb', count(*) from location_tb
union all select 'disaster', count(*) from disaster
union all select 'rescue_team', count(*) from rescue_team
union all select 'hospital', count(*) from hospital
union all select 'relief_camp', count(*) from relief_camp
union all select 'Resource', count(*) from Resources
union all select 'disaster_team', count(*) from disaster_team
union all select 'resource_Allocation', count(*) from resource_Allocation;
--view extra 
create view vw_ActiveDisasterSummary as
select
    d.disaster_id,
    dt.d_type_name        as disaster_type,
    l.city,
    l.area,
    d.severity,
    d.affected_people,
    rt.team_name         as assigned_team,
    rt.aavailability       as team_status
from disaster d
inner join disaster_type dt on d.disaster_type_id = dt.disaster_type_id
inner join location_tb l on d.location_id = l.location_id
left join disaster_team dtm on d.disaster_id = dtm.disaster_id
left join rescue_team rt on dtm.team_id = rt.team_id
where d.sstatus = 'Active';

select * from vw_ActiveDisasterSummary;
create function fn_CampOccupancyPercentage (@camp_id int)
returns decimal(5,2)
as
begin
    declare @percentage decimal(5,2);

    select @percentage = (cast(occupied as decimal(10,2)) / capacity) * 100
    from relief_camp
    where camp_id = @camp_id;

    return @percentage;
end;
select camp_name, capacity, occupied,
       dbo.fn_CampOccupancyPercentage(camp_id) as occupancy_percent
from relief_camp;

begin try
    begin transaction;

    insert into resource_Allocation
    (disaster_id, resource_id, camp_id, quantity_allocated, allocation_date)
    values (1, 2, 1, 300, getdate());

    update Resources set quantity = quantity - 300 where resource_id = 2;

    commit transaction;
    print 'Success: Resources allocated safely.';
end try
begin catch
    rollback transaction;
    print 'Error occurred — transaction rolled back. No data changed.';
end catch
select resource_id, resource_name, quantity from Resources where resource_id = 2;
