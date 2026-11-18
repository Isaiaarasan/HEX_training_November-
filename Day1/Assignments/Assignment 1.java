import java.util.ArrayDeque;
import java.util.Queue;

public class QueueDemo {
    public static void main(String[] args) {

        Queue<String> queue = new ArrayDeque<>();

        queue.add("Harry");
        queue.add("Ronald");
        queue.add("Hermione");
        queue.add("Draco");

        System.out.println("Queue: " + queue);

        System.out.println("Front: " + queue.peek());

        System.out.println("Removed: " + queue.poll());
        System.out.println("Removed: " + queue.poll());

        System.out.println("Remaining Queue: " + queue);

        System.out.println("Size: " + queue.size());

        System.out.println("Is Empty: " + queue.isEmpty());
    }
}