public class MyRunnable implements Runnable{
    
    @Override
    public void run() {
        for (int i = 10; i >= 1; i--) {
            System.out.println("Counting down using MyRunnable: " + i);
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        System.out.println("MyRunnable has finished executing!");
    }

}
