CREATE DATABASE desec;
CREATE USER desec IDENTIFIED BY 'test123';
GRANT INSERT, UPDATE, DELETE ON desec.* TO desec;

CREATE DATABASE pdns;
CREATE USER pdns IDENTIFIED BY '123test';
GRANT SELECT, INSERT, UPDATE, DELETE ON pdns.* TO pdns;

CREATE USER poweradmin IDENTIFIED BY '123passphrase';
GRANT SELECT, INSERT, UPDATE, DELETE ON pdns.* TO poweradmin;