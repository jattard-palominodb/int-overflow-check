Integer Overflow MySQL Check
================================

*This program was developed to review the max values of integer fields in an attempt to anticipate an overflow catastrophe.*

Usage:
    
* create table int_overflow:  
CREATE TABLE `int_overflow` (  
  `schema_name` varchar(64) DEFAULT NULL,  
  `table_name` varchar(64) DEFAULT NULL,  
  `column_name` varchar(64) DEFAULT NULL,  
  `column_type` varchar(32) DEFAULT NULL,  
  `max_value` bigint(20) DEFAULT NULL,  
  `of_pct` int(11) DEFAULT NULL,  
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
) ENGINE=InnoDB DEFAULT CHARSET=latin1  
    
* Edit db connection info in int_overflow.pl  
  
* execute script without arguments: ./int_overflow.pl  

