<p>This program was developed to review the max values of integer fields in an attempt to anticipate an overflow catastrophe.</p>

<p>Usage:
1. create table int<em>overflow:
CREATE TABLE <code>int_overflow</code> (
  <code>schema_name</code> varchar(64) DEFAULT NULL,
  <code>table_name</code> varchar(64) DEFAULT NULL,
  <code>column_name</code> varchar(64) DEFAULT NULL,
  <code>column_type</code> varchar(32) DEFAULT NULL,
  <code>max_value</code> bigint(20) DEFAULT NULL,
  <code>of_pct</code> int(11) DEFAULT NULL,
  <code>date</code> timestamp NOT NULL DEFAULT CURRENT</em>TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 </p>

<ol>
<li><p>Edit db connection info in int_overflow.pl</p></li>
<li><p>execute script without arguments: ./int_overflow.pl</p></li>
</ol>

<p>Example output (of<em>pct is the overflow percentage... 100% means that value reached upper limit):
+-------------+-----------------------+-------------+------------------+-----------+--------+---------------------+
| schema</em>name | table<em>name            | column</em>name | column<em>type      | max</em>value | of_pct | date                |
+-------------+-----------------------+-------------+------------------+-----------+--------+---------------------+
| ebonydb     | CurrentRollingMetrics | id          | bigint           |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | CurrentRollingMetrics | metricId    | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | CurrentRollingMetrics | value       | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | Metrics               | id          | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | Project               | id          | int              |         5 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | date                  | id          | int              |         4 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t1                    | id          | int              |         4 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t1                    | age         | int              |        40 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t2                    | id          | int              |         1 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t3                    | id          | int              |         1 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t4                    | id          | int              |         1 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t5                    | id          | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t6                    | id          | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t7                    | id          | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t7                    | age         | int              |         0 |      0 | 2012-10-17 16:50:27 |
| ebonydb     | t8                    | id          | smallint         |         3 |      0 | 2012-10-17 16:50:28 |
| ebonydb     | t8                    | age         | smallint         |        24 |      0 | 2012-10-17 16:50:28 |
| ebonydb     | t9                    | col1        | int              |         4 |      0 | 2012-10-17 16:50:28 |
| ebonydb     | t9                    | col2        | int              |         2 |      0 | 2012-10-17 16:50:28 |
| ebonydb     | tablec                | id          | int              |         5 |      0 | 2012-10-17 16:50:28 |
| ebonydb     | tablec                | col1        | int              |         5 |      0 | 2012-10-17 16:50:28 |
| ebonydb     | test1                 | id          | int              |         4 |      0 | 2012-10-17 16:50:28 |
+-------------+-----------------------+-------------+------------------+-----------+--------+---------------------+</p>

<p>The next version of the script will accept an external configuration file for database connection info.</p>
