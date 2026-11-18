import java.util.*;

class Courses {
    int id;
    String name;
    double Price;

    Courses(int id, String name , double Price){
        this.id = id;
        this.name = name;
        this.Price = Price;
    }

    public String toString(){
        System.out.println("Courses ID: " + id);
        System.out.println("Courses Name: " + name);
        System.out.println("Courses Price: " + Price);
        return "Courses ID: " + id + ", Courses Name: " + name + ", Courses Price: " + Price;  
    }
}

public class Day2Assignment1 {
    public static void main(String[] args) {
        System.out.println("Hello, World!");

        ArrayList<Courses> courses = new ArrayList<>();
        courses.add(new Courses(101, "Java", 15000));
        courses.add(new Courses(102, "Python", 12000));
        courses.add(new Courses(103, "React", 20000));
        courses.add(new Courses(104, "SQL" ,30000));
        courses.add(new Courses(105, "Angular", 18000));

        //for low to to high price
        Collections.sort(courses, Comparator.comparingDouble(c -> c.Price));

        System.out.println("Fee: Low to High");
        for (Courses c : courses) {
            System.out.println(c);
        }

        //for high to low price
        Collections.sort(courses,
        Comparator.comparingDouble((Courses c) -> c.Price).reversed()); 
        System.out.println("\nFee: High to Low");
        for (Courses c : courses) {
            System.out.println(c);
        }

        // Name: A to Z
        Collections.sort(courses,
            Comparator.comparing(c -> c.name));

        System.out.println("\nName: A to Z");
        for (Courses c : courses) {
            System.out.println(c);
        }
    }

}