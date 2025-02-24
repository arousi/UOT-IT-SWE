<?php
include "connection.php"; //connect to the database and return $conn
try {
    $query = "INSERT INTO user-fincaces(`User-Name`,`Income`,`Expenses`, `Debt`, `Savings`, `Qs`, `ID`) VALUES
    (:username,:Income,:Expenses, :Debt, :Savings, :Qs, :ID)";
    $stmt = $conn->Prepare($query);

    $stmt->bindParam(':username', $_POST["idst"]); /*To change idst*/
    $stmt->bindParam(':Income', $_POST["stname"]);/*To change idst*/
    $stmt->bindParam(':Expenses', $_POST["stpass"]);/*To change idst*/

    $stmt->bindParam(':Debt', $_POST["idst"]);/*To change idst*/
    $stmt->bindParam(':Savings', $_POST["stname"]);/*To change idst*/
    $stmt->bindParam(':Qs', $_POST["stpass"]);/*To change idst*/
    if ($stmt->execute()) {
        echo "record added successfully";
    }
} catch (Exception $ex) {
    echo $ex->getMessage();
}
$conn = null;