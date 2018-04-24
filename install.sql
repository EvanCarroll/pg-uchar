DROP DOMAIN IF EXISTS uchar CASCADE;
CREATE DOMAIN uchar AS "char";

CREATE FUNCTION to_uchar( i int )
RETURNS uchar AS $$
  SELECT (i-128)::uchar;
$$ LANGUAGE sql
IMMUTABLE;

CREATE FUNCTION to_uchar( i smallint )
RETURNS uchar AS $$
  SELECT (i-128)::uchar;
$$ LANGUAGE sql
IMMUTABLE;

CREATE FUNCTION to_uchar( b bit(8) )
RETURNS uchar AS $$
  SELECT (b::int - 128)::uchar;
$$ LANGUAGE sql
IMMUTABLE;

CREATE FUNCTION to_smallint( uc uchar )
RETURNS smallint AS $$
  SELECT (uc::int + 128)::int::smallint;
$$ LANGUAGE sql
IMMUTABLE;

CREATE FUNCTION to_int( uc uchar )
RETURNS int AS $$
  SELECT (uc::int + 128)::int;
$$ LANGUAGE sql
IMMUTABLE;

CREATE FUNCTION to_bit8( uc uchar )
RETURNS bit(8) AS $$
  SELECT (uc::int + 128)::bit(8);
$$ LANGUAGE sql
IMMUTABLE;

