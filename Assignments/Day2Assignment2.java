import java.util.*;

class Node{
    int data;
    Node left, right;

    Node(int data){
        this.data = data;
        left = right = null;
    }
}
public class Day2Assignment2{
        Node root;

        Node insert(Node root, int data){
            if(root == null){
                root = new Node(data);
                return root;
            }
            if(data < root.data){
                root.left = insert(root.left, data);
            }else if(data > root.data){
                root.right = insert(root.right, data);
            }
            return root;
        }

        //Preorder Traversal
        void preorder(Node root){
            if(root != null){
                System.out.print(root.data + " ");
                preorder(root.left);
                preorder(root.right);
            }
        }

        //Inorder Traversal
        void inorder(Node root){
            if(root != null){
                inorder(root.left);
                System.out.print(root.data + " ");
                inorder(root.right);
            }
        }

        //Postorder Traversal
        void postorder(Node root){
            if(root != null){
                postorder(root.left);
                postorder(root.right);
                System.out.print(root.data + " ");
            }
        }

        public static void main(String[] args) {
            Day2Assignment2 tree = new Day2Assignment2();
            int[] values = {50, 30, 70, 20, 40, 60, 80, 65};
            for (int value : values) {
            tree.root = tree.insert(tree.root, value);
        }
            System.out.println("Preorder Traversal:");
            tree.preorder(tree.root);

            System.out.println("\nInorder Traversal:");
            tree.inorder(tree.root);

            System.out.println("\nPostorder Traversal:");
            tree.postorder(tree.root);
        }
}