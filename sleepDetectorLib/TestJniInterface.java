public class TestJniInterface {

  static {
    System.out.printf("Loading JNI interface library...\n");
    System.loadLibrary("JniInterface");
  }

  public static void main(String[] argv) {
    System.out.printf("Invoking JNI method...\n");
    new JniInterface().log();
  }
}
