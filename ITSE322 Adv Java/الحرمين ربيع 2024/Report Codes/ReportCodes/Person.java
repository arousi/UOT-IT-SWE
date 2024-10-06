public class Person implements Displayable {
    private String name;
    private int age;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        if (age > 0) {
            this.age = age;
        }
    }

    @Override
    public void displayInfo() {
        System.out.println("Name: " + name);
    }

    public void displayInfo(boolean showAge) {
        System.out.println("Name: " + name);
        if (showAge) {
            System.out.println("Age: " + age);
        }
    }
}