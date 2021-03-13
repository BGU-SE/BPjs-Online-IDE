package il.ac.bgu.se.bp.runner;


import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages="il.ac.bgu.se.bp")
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
