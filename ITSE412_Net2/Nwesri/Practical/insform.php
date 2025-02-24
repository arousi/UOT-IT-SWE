<?php
include "connection.php"; //connect to the database and return $conn
try {
    $query = "INSERT INTO student(ID,name,password) VALUES
    (:stid,:stname,:stpassword)";
    $stmt = $conn->Prepare($query);
    $stmt->bindParam(':stid', $_POST["idst"]);
    $stmt->bindParam(':stname', $_POST["stname"]);
    $stmt->bindParam(':stpassword', $_POST["stpass"]);
    if ($stmt->execute()) {
        echo "record added successfully";
    }
} catch (Exception $ex) {
    echo $ex->getMessage();
}
$conn = null;
