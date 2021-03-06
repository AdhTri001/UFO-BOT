apt update
apt upgrade

apt-get install sudo

# sudo apt-get install software-properties-common

sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt install oracle-java16-installer

sudo add-apt-repository ppa:deadsnakes/ppa
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886
sudo apt update
sudo apt install python3.8

sudo apt-get install libmagickwand-dev
python3.8 -m pip install --upgrade pip setuptools
python3.8 -m pip install -U matplotlib wand colorama discord.py akinator.py[fast_async] wavelink wikipedia fancy-text pillow pilmoji art py_expression_eval clean-text[gpl] asyncpg numpy

---------------------------------------

sudo apt -y install vim bash-completion wget
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list

sudo apt-get update && sudo apt-get upgrade

sudo apt install postgresql-13 postgresql-client-13

sudo service postgresql start

sudo su - postgres

# userdel postgres

# useradd postgres

# sudo gpasswd -a postgres ssl-cert

# chown -R postgres:postgres /var/lib/postgresql
# chown -R postgres:postgres /etc/postgresql
# chown -R postgres:postgres /var/log/postgresql
# chown -R postgres:postgres /var/run/postgresql

# sudo /etc/init.d/postgresql restart

pg_dump postgres://ufobot:yoyome9104@localhost:5432/ufobotdb < ufobotdb.sql

https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e

psql conn_uri < ufobotdb.sql

OR

CREATE USER ufobot WITH SUPERUSER;
ALTER USER ufobot WITH password 'yoyome9104';
CREATE DATABASE ufobotdb;

\c ufobotdb

CREATE TABLE giveaways (
    winner_count smallint,
    message_id numeric(18,0) NOT NULL,
    "timestamp" integer,
    prize text,
    guild_id numeric(18,0),
    channel_id numeric(18,0)
);
CREATE TABLE guildsettings (
    guild_id numeric(18,0) UNIQUE NOT NULL,
    prefix text,
    modrole_id numeric(18,0),
    muterole_id numeric(18,0),
    logch numeric(18,0),
    greetch numeric(18,0),
    discmds text[],
    warns json,
    greetmsg text,
    ranks numeric(18,0)[],
    logging text[],
    logs jsonb[],
    kickat integer DEFAULT 0,
    banat integer DEFAULT 0,
    startrole_id numeric(18,0),
    mutedmems numeric(18,0)[],
    blackch numeric(18,0)[],
    PRIMARY KEY (guild_id)
);
CREATE TABLE snipes (
    channel_id numeric(18,0) UNIQUE NOT NULL,
    "timestamp" integer NOT NULL,
    message_content text,
    user_id numeric(18,0),
    PRIMARY KEY (channel_id)
);
CREATE TABLE tempbans (
    user_id numeric(18,0),
    guild_id numeric(18,0),
    "timestamp" integer
);
CREATE TABLE timers (
    reminder_id serial PRIMARY KEY,
    channel_id numeric(18,0),
    reason text,
    "timestamp" integer
);

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

python3.8 UFO_Bot.py