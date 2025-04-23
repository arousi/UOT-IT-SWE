class Resource {
    private final String name;

    public Resource(String name) {
        this.name = name;
    }

    public synchronized void useResource(Resource otherResource) {
        System.out.println(Thread.currentThread().getName() + " using " + this.name);
        try {
            Thread.sleep(50); // Simulate some work
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(Thread.currentThread().getName() + " trying to use " + otherResource.name);
        otherResource.useResource(this);
    }
}
