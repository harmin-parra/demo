package starter.acceptancetests;

import net.serenitybdd.junit5.SerenityJUnit5Extension;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import starter.petstore.PetstoreActions;
import starter.petstore.Pet;

@ExtendWith(SerenityJUnit5Extension.class)
public class TestPetstoreRestAPI {

    Pet pet;
    PetstoreActions petApi;

    @Test
    public void addPet() {
        petApi.givenPetstoreExits();
        pet = petApi.whenIAddPet();
        petApi.thenPetIsAdded();
    }

    @Test
    public void getPet() {
        petApi.givenPetExists();
        pet = petApi.whenIGetPet();
        petApi.thenIGetPetInfo();
    }

    @Test
    public void deletePet() {
        petApi.givenPetExists();
        petApi.whenIDeletePet();
        petApi.thenPetIsDeleted();
    }
}
