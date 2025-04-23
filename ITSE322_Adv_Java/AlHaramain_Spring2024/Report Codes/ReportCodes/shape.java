public abstract class Shape implements Displayable {
    public abstract double calculateArea();

    @Override
    public void displayInfo() {
        System.out.println("This is a shape.");
    }
}