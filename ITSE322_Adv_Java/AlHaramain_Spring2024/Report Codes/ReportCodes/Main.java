public class Main {
    public static void main(String[] args) {
        // Encapsulation example
        Person person = new Person();
        person.setName("John Doe");
        person.setAge(30);
        person.displayInfo(true);

        // Inheritance and Polymorphism example
        Employee employee = new Employee();
        employee.setName("Jane Smith");
        employee.setAge(28);
        employee.setEmployeeId("E123");
        employee.displayInfo();

        // Abstraction and Interface example
        Displayable circle = new Circle(5.0);
        Displayable rectangle = new Rectangle(4.0, 6.0);
        
        circle.displayInfo();
        System.out.println("Area: " + ((Circle) circle).calculateArea());

        rectangle.displayInfo();
        System.out.println("Area: " + ((Rectangle) rectangle).calculateArea());
    }
}