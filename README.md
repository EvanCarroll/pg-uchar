pg_char
=====

This extension will create functions not casts to help assist in this process of going from an **unsigned one-byte int range of `[0-255]`** to a **signed one byte range that character requires of `[-128,127]`.** This module makes use of a new [`DOMAIN`](https://www.postgresql.org/docs/current/static/sql-createdomain.html), `uchar`. This stores as a one-byte [Special Character Type `"char"`](https://www.postgresql.org/docs/current/static/datatype-character.html).

SYNOPSIS
====

Storing the values in the range of [0-255] on the table.

```sql
CREATE TABLE t(x) AS VALUES
  (to_uchar(255)),
  (to_uchar(0));
```

Convert them to bit(8);

```
SELECT to_bit8(x) FROM t;
 to_bit8  
----------
 11111111
 00000000
(2 rows)
```

```sql
UPDATE t
  SET x = to_uchar( to_bit8(x) & (x'fc')::bit(8) );
```

Perhaps you want to clear out the lower-order two bits, you can do that with BITWISE-AND,

```
SELECT to_bit8(x) FROM t;
 to_bit8  
----------
 11111100
 00000000
(2 rows)
```

FUNCTIONS
====

To `uchar`
----

* `to_uchar( int )`
* `to_uchar( smallint )`
* `to_uchar( bit(8) )`

From `uchar`
----

* `to_smallint( uchar )`
* `to_int( uchar )`
* `to_byte8( uchar )`

AUTHOR
====

* Evan Carroll <me@evancarroll.com>
