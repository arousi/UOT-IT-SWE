<?php
Include"connection.php"; //connect to the database and return $conn
try{
    $query = "update student set name=:stname,password=:stpassword where ID=:stid";
    $stmt = $conn->Prepare($query);
    $stmt->bindParam(':stid',$_POST["idst"]);
    $stmt->bindParam(':stname',$_POST["stname"] );
    $stmt->bindParam(':stpassword',$_POST["stpass"] );
    if ($stmt->execute())
    {
    echo "Data Changed successfully";
    }
    }
    catch (Exception $ex)
    {
    echo $ex->getMessage();
    }
    $conn = null;
?>