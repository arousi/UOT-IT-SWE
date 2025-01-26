public class ThreadTest {
    public static void main(String[] args) {

        MyThread thread1 = new MyThread();
        
        MyRunnable runnable1 = new MyRunnable();
        Thread thread2 = new Thread(runnable1);
        
        MyThread thread3 = new MyThread();

        thread1.start();
        thread2.start();
        thread3.start();

    }
}
