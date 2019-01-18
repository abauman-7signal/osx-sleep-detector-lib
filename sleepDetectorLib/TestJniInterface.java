public class TestJniInterface {

  static {
    System.out.printf("Loading JNI interface library...\n");
    System.loadLibrary("JniInterface");
  }

  public static void main(String[] argv) {
    System.out.printf("Invoking JNI method...\n");
    new JniInterface().log("Hello from " + (new TestJniInterface()).getClass().getSimpleName());

    System.out.printf("Type Ctl+C to exit!\n");
    while(true) {
      try {
        Thread.sleep(1000);
      } catch (InterruptedException ex) {

      }
    }
  }
}
