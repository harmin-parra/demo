package rest_api_rest_assured;

import io.qameta.allure.Allure;
import io.qameta.allure.restassured.AllureRestAssured;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;

import static io.restassured.RestAssured.*;
import static org.hamcrest.Matchers.*;

import java.util.HashMap;
import java.util.Map;


public class PetstoreTest {

    private int id = 531;


    @BeforeAll
    public static void setUp() {
    	RestAssured.baseURI = "https://petstore.swagger.io";
    	RestAssured.basePath = "/v2/pet";
    	RestAssured.requestSpecification = 
    	    (RequestSpecification) new RequestSpecBuilder()
    	        .setContentType(ContentType.JSON)
    	        .setAccept(ContentType.JSON)
    	        .build(); //.log().uri().log().method();
    }

    @Test
    public void add_pet() {
        Allure.getLifecycle().updateTestCase(tr -> tr.getLabels().removeIf(label -> "suite".equals(label.getName())));
        Allure.feature("REST api (rest-assured)");
        Allure.story("Petstore");
        Allure.suite("REST api (rest-assured)");

    	Map<String, Object> payload = new HashMap<String, Object>();
        payload.put("id", id);
        payload.put("name", "Cookie");
        payload.put("status", "sold");

        with().
            filter(new AllureRestAssured()).
    	    body(payload).
        when().
        	post("/").
        then().
        	statusCode(200).
        	body("id", equalTo(id)).
        	body("name", equalTo("Cookie")).
        	body("status", equalTo("sold"));
    }

    @Test
    public void get_pet() {
        Allure.getLifecycle().updateTestCase(tr -> tr.getLabels().removeIf(label -> "suite".equals(label.getName())));
        Allure.feature("REST api (rest-assured)");
        Allure.story("Petstore");
        Allure.suite("REST api (rest-assured)");

        with().
            filter(new AllureRestAssured()).
        when().
    	    get("/{id}", id).
    	then().
            statusCode(200).
            body("id", equalTo(id)).
            body("name", equalTo("Cookie")).
            body("status", equalTo("sold"));
    }
    
    @Test
    public void delete_pet() {
        Allure.getLifecycle().updateTestCase(tr -> tr.getLabels().removeIf(label -> "suite".equals(label.getName())));
        Allure.feature("REST api (rest-assured)");
        Allure.story("Petstore");
        Allure.suite("REST api (rest-assured)");

        // Delete pet
        with().
            filter(new AllureRestAssured()).
        when().
            delete("/{id}", id).
        then().
            statusCode(200).
            body("message", equalTo(Integer.toString(id)));

        // Get deleted pet
        with().
            filter(new AllureRestAssured()).
        when().
            get("/{id}", id).
        then().
            statusCode(404).
            body("type", equalTo("error")).
            body("message", equalTo("Pet not found"));
    }

}
