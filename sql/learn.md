### How much SQL to learn
    > Core (must-know)
        * SELECT, WHERE, ORDER BY, GROUP BY, HAVING
        * All Join(INNER, LEFT, RIGHT, FULL) know exactly what each return 
        * Aggregate functions (COUNT,SUM,AVG,MIN,MAX)
        * INSERT,UPDATE,DELETE, and understanding transaction(BEGIN/COMMIT/ROLLBACK)
        * Primary keys, foregin keys, constraints(NOT NULL, UNIQUE, CHECK)
        * Basic indexing -- what an index is , what it helps, what it doesn't

    > Intermediate(needed to be a solid backend dev)
        * Subqueries and CTEs (WITH clause) - very common in real-world queries
        * window functions(ROW_NUMBER, RANK,LAG/LEAD, partitioned aggregate)
        * EXPLAIN/EXPLAIN ANALYSE - reading queries plant to understand why something is show
        * understanding N+1 queries problems and how to 
        * Normalization basics(1NF, 2NF, 3NF) and when to denormalize
        * Isolation levels and what problems they solve (dirty read, plantom, reads )

    > PostgreSQL -specific
        * JSONB column and querying them (very common for flexible schemas)
        * array types
        * UPSERT
        * Partial and expression indexes
        * pg_stat_statements for finding slow queries
        * Basic understanding of VACUUM/autovacuum (why postgres needs it )