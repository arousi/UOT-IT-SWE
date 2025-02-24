<!DOCTYPE html>
<html>

<head>
  <title> delete form</title>
  <meta charset="UTF-8">
</head>

<body>
  <form id="deletForm" action="" method="POST">
    <fieldset>
      <legend>Delete Data </legend>
      <label>Type ID student you want to delete:</label>
      <p>ID: <input type="text" id="ids" name="idst" required /></p>
      <p><input type="submit" value="delete Data" /></p>
    </fieldset>
  </form>
</body>

</html>
<?php
include "connection.php"; //connect to the database and return $conn
if (isset($_POST["idst"])) {
  try {
    $query = "SELECT * FROM student WHERE ID=:stid";
    $stmt = $conn->prepare($query);
    $stmt->bindParam(':stid', $_POST["idst"]);
    $stmt->execute();
    if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
      dlet($_POST["idst"]);

    } else
      echo " ID not Found in the table";

  } catch (Exception $ex) {
    echo $ex->getMessage();
  }
}
?>
<?php
function dlet($id)
{
  include "connection.php"; //connect to the database and return $conn
  $query = "DELETE FROM student WHERE ID=:stid";
  $stmt = $conn->prepare($query);
  $stmt->bindParam(':stid', $id);
  if ($stmt->execute()) {
    echo "record Deleted Successfully";
  }
}
