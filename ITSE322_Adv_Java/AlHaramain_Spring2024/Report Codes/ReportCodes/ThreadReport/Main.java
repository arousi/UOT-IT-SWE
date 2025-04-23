public class Main {
    public static void main(String[] args) {
        // Demonstrate basic multithreading with Runnable
        Thread hiThread = new Thread(new HiRunnable());
        Thread helloThread = new Thread(new HelloRunnable());

        hiThread.start();
        helloThread.start();

        try {
            hiThread.join();
            helloThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        //  thread safety
        Counter counter = new Counter();
        Thread counterThread1 = new Thread(new CounterRunnable(counter));
        Thread counterThread2 = new Thread(new CounterRunnable(counter));

        counterThread1.start();
        counterThread2.start();

        try {
            counterThread1.join();
            counterThread2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Counter value: " + counter.getCount());

        // Demonstrate deadlock
        Resource resource1 = new Resource("Resource1");
        Resource resource2 = new Resource("Resource2");

        Thread thread1 = new Thread(() -> resource1.useResource(resource2), "Thread1");
        Thread thread2 = new Thread(() -> resource2.useResource(resource1), "Thread2");

        thread1.start();
        thread2.start();

        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}