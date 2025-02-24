<?php
Include"connection.php";

try {
 
  // sql to create table
  $sql = "CREATE TABLE student (
    ID int(11)  primary key NOT NULL,
    name varchar(120),
    password varchar(120)
    )";

  // use exec() because no results are returned
  $conn->exec($sql);
  echo "Table student created successfully";
} catch(PDOException $e) {
  echo $sql . "<br>" . $e->getMessage();
}

$conn = null;

