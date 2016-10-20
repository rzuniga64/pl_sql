REM Random.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This package contains an initialization section.

CREATE OR REPLACE PACKAGE Random AS
  -- Random number generator.  Uses the same algorithm as the
  -- rand() function in C.

  -- Used to change the seed.  From a given seed, the same
  -- sequence of random numbers will be generated.
  PROCEDURE ChangeSeed(p_NewSeed IN NUMBER);

  -- Returns a random integer between 1 and 32767.
  FUNCTION Rand RETURN NUMBER;

  -- Same as Rand, but with a procedural interface.
  PROCEDURE GetRand(p_RandomNumber OUT NUMBER);

  -- Returns a random integer between 1 and p_MaxVal.
  FUNCTION RandMax(p_MaxVal IN NUMBER) RETURN NUMBER;

  -- Same as RandMax, but with a procedural interface.
  PROCEDURE GetRandMax(p_RandomNumber OUT NUMBER,
                       p_MaxVal IN NUMBER);
END Random;
/

CREATE OR REPLACE PACKAGE BODY Random AS

  /* Used for calculating the next number. */
  v_Multiplier  CONSTANT NUMBER := 22695477;
  v_Increment   CONSTANT NUMBER := 1;

  /* Seed used to generate random sequence. */
  v_Seed        number := 1;

  PROCEDURE ChangeSeed(p_NewSeed IN NUMBER) IS
  BEGIN
    v_Seed := p_NewSeed;
  END ChangeSeed;

  FUNCTION Rand RETURN NUMBER IS
  BEGIN
    v_Seed := MOD(v_Multiplier * v_Seed + v_Increment,
                  (2 ** 32));
    RETURN BITAND(v_Seed/(2 ** 16), 32767);
  END Rand;

  PROCEDURE GetRand(p_RandomNumber OUT NUMBER) IS
  BEGIN
    -- Simply call Rand and return the value.
    p_RandomNumber := Rand;
  END GetRand;

  FUNCTION RandMax(p_MaxVal IN NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN MOD(Rand, p_MaxVal) + 1;
  END RandMax;

  PROCEDURE GetRandMax(p_RandomNumber OUT NUMBER,
                       p_MaxVal IN NUMBER) IS
  BEGIN
    -- Simply call RandMax and return the value.
    p_RandomNumber := RandMax(p_MaxVal);
  END GetRandMax;

BEGIN
  /* Package initialization.  Initialize the seed to the current
     time in seconds. */
  ChangeSeed(TO_NUMBER(TO_CHAR(SYSDATE, 'SSSSS')));
END Random;
/
