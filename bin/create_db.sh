#!/bin/bash
sqlite3 attendance.db "CREATE TABLE attendants (id INTEGER PRIMARY KEY, firstName text, lastName text);\
  CREATE TABLE attendancies (id INTEGER PRIMARY KEY, attendantId INTEGER, day DATE, status BOOLEAN, FOREIGN KEY(attendantId) REFERENCES attendants(id) ON DELETE CASCADE);\
"
