<!DOCTYPE html>
<html>

<head>
   <title> form</title>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
   <?php
      $name = $_POST["name"];
      $email = $_POST["email"];
      $url = $_POST["purl"];
      $comment = $_POST["comment"];
      $gender = $_POST["gender"];
      echo "<h2> Your Input: </h2>";
   ?>
   <table border="2">
      <tr>
         <td>
            Name
         </td>
         <td>
            <?php echo $name; ?>
         </td>
      </tr>
      <tr>
         <td>
            Email
         </td>
         <td>
            <?php echo $email; ?>
         </td>
      </tr>
      <tr>
         <td>
            URL
         </td>
         <td>
            <?php
            if ($url == "")
               echo "URL Not Found";
            else
               echo $url; ?>
         </td>
      </tr>
      <tr>
         <td>
            Comment
         </td>
         <td>
            <?php echo $comment; ?>
         </td>
      </tr>
      <tr>
         <td>
            Gender
         </td>
         <td>
            <?php echo $gender; ?>
         </td>
      </tr>
   </table>
</body>

</html>