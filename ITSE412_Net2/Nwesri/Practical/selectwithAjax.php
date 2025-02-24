<?php
include "connection.php"; //connect to the database and return $conn
try {
    $query = "SELECT * FROM student WHERE ID=:stid";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':stid', $_GET["q"]);
    $stmt->execute();
    if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "ID: " . $row['ID'] . "<br>";
        echo "NAME: " . $row['name'] . "<br>";
        echo "Password: " . $row['password'] . "<br>";
    } else
        echo "The ID is not found in the table";
} catch (Exception $ex) {
    echo $ex->getMessage();
}

