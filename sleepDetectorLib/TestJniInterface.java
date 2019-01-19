public class TestJniInterface {

  static JniInterface jniInterface;

  static {
    System.out.printf("Loading JNI interface library...\n");
    System.loadLibrary("JniInterface");
  }

  public static void main(String[] argv) {
    System.out.printf("Invoking JNI method...\n");
    jniInterface = new JniInterface();
    jniInterface.log("Hello from " + (new TestJniInterface()).getClass().getSimpleName());

    System.out.printf("Type Ctl+C to exit!\n");

    int previousScreenSaverState = 0;
    int currentScreenSaverState = previousScreenSaverState;
    while(true) {
      currentScreenSaverState = jniInterface.getScreenSaverState();
      if (currentScreenSaverState != previousScreenSaverState) {
        System.out.printf("Screen saver state changed to " + currentScreenSaverState + "\n");
        previousScreenSaverState = currentScreenSaverState;
      }
      try {
        Thread.sleep(1000);
      } catch (InterruptedException ex) {

      }
    }
  }
}
