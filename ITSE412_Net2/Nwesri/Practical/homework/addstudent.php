<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Validation</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        .error {
            border-color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>الامتحان النهائي لمقرر النترنت المتقدمة</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-md-9">
                <h2>إضافة طالب جديد</h2>
                <form id="studentForm">
                    <div class="form-group">
                        <label for="stid">رقم الطالب:</label>
                        <input type="text" class="form-control" name="stid" placeholder="رقم الطالب" id="stid">
                    </div>
                    <div class="form-group">
                        <label for="stname">اسم الطالب:</label>
                        <input type="text" class="form-control" name="stname" placeholder="إسم الطالب" id="stname">
                    </div>
                    <div class="form-group">
                        <label for="address">العنوان :</label>
                        <input type="text" class="form-control" name="address" id="address" placeholder="إدخل العنوان">
                    </div>
                    <button type="button" class="btn btn-default" id="saveBtn">اضافة</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // Function to validate STID input
            function validateStid(input) {
                var stid = input.val().trim(); // Remove leading and trailing spaces
                if (stid.length > 12 || stid === '' || stid.length < 1) {
                    input.addClass('error');
                    return false;
                } else {
                    input.removeClass('error');
                    return true;
                }
            }

            // Function to validate form fields
            function validateForm() {
                var valid = true;

                // Check STID
                valid = valid && validateStid($('#stid'));

                // Check other fields for emptiness
                $('#stname, #address').each(function() {
                    if ($(this).val().trim() === '') { // Remove leading and trailing spaces
                        $(this).addClass('error');
                        valid = false;
                    } else {
                        $(this).removeClass('error');
                    }
                });

                return valid;
            }

            // On save button click
            $('#saveBtn').click(function() {
                if (validateForm()) {
                    var formData = {
                        stid: $('#stid').val().trim(),
                        stname: $('#stname').val().trim(),
                        address: $('#address').val().trim()
                    };

                    $.ajax({
                        type: 'POST',
                        url: 'savestudentdata.php', 
                        data: formData,
                        success: function(response) {
                            // Clear form fields
                            $('#stid, #stname, #address').val('');
                            alert('تم اضافة البيانات بنجاح');
                        },
                        error: function(xhr, status, error) {
                            // Handle errors
                            console.error(xhr.responseText); 
                            alert('حدث خطأ أثناء ارسال البيانات');
                        }
                    });
                }
            });

            // On input change, remove error class
            $('#stid, #stname, #address').on('input', function() {
                $(this).removeClass('error');
            });
        });
    </script>
</body>
</html>
