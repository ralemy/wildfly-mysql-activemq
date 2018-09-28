--
-- Event TABLES
--


;


DROP TABLE IF EXISTS `eventlog`;
create table eventlog (
	Id BIGINT(20) not null auto_increment,
	TypeId INTEGER not null,
	LevelId INTEGER not null,
	TagId INTEGER null,
	TaggedObjectId INTEGER null,
	GateId INTEGER null,
	NodeId INTEGER null,
	AccountId INTEGER null,
	UserId INTEGER null,
	BuildingId INTEGER null,
	FloorId INTEGER null,
	AreaId INTEGER null,
	PositionX smallint null,
	PositionY smallint null,
	PositionZ smallint null,
	LogDateTime DATETIME not null,

  constraint PkEventLog_Id primary key (Id),
  constraint FkEventLog_LevelId foreign key (LevelId) references EvLevels(Id),
  constraint FkEventLog_TypeId foreign key (TypeId) references EvTypes (Id),
  constraint FkEventLog_TagId foreign key (TagId) references Tags (Id),
  constraint FkEventLog_TaggedObjectId foreign key (TaggedObjectId) references TaggedObjects (Id),
  constraint FkEventLog_GateId foreign key (GateId) references Gates (Id),
  constraint FkEventLog_NodeId foreign key (NodeId) references Nodes (Id),
  constraint FkEventLog_AccountId foreign key (AccountId) references Users (Id),
  constraint FkEventLog_UserId foreign key (UserId) references Users (Id),
  constraint FkEventLog_BuildingId foreign key (BuildingId) references Areas (Id),
  constraint FkEventLog_FloorId foreign key (FloorId) references Areas (Id),
  constraint FkEventLog_AreaId foreign key (AreaId) references Areas (Id)
);

DROP TABLE IF EXISTS `evvideo`;
create table evvideo (
  Id BIGINT not null,
  LogDateTime DATETIME not null,
  Cameras varchar(2000) null,
  constraint PkEvVideo_Id primary key (Id),
  constraint FkEvVideo_Id foreign key (Id) references EventLog (Id) on delete cascade
);

DROP TABLE IF EXISTS `evrssi`;
create table evrssi (
Id BIGINT not null,
TagReaderId INTEGER not null,
Rssi INTEGER not null,
constraint EvRssi_PK primary key (Id, TagReaderId),
constraint FkEvRssi_Id foreign key (Id) references EventLog (Id) on delete cascade,
constraint FkEvRssi_TagReaderId foreign key (TagReaderId) references TagReaders (Id)
);


DROP TABLE IF EXISTS `evnotes`;
create table `evnotes` (
 Id BIGINT not null,
 Note VARCHAR(255) not null,
 constraint EvNotes_PK primary key (Id),
 constraint FkEvNotes_Id foreign key (Id) references EventLog (Id) on delete cascade
);
