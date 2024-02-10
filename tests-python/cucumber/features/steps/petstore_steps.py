from behave import given, when, then
from cucumber.model import petstore
import allure

ID = 5432


@given('I have a pet store')
def step_impl(context):
    petstore.ping()


@given('A pet exists in the store')
def step_impl(context):
    context.id = ID
    petstore.get(context.id)


@when('I query a pet')
def step_impl(context):
    res = petstore.get(context.id)
    context.result = res


@then('I get the pet information')
def step_impl(context):
    assert context.result.status_code == 200
    assert 'id' in context.result.json()
    assert 'name' in context.result.json()
    assert 'status' in context.result.json()


@when('I add a pet')
def step_impl(context):
    payload = {
        "id": ID,
        "name": "doggie",
        "status": "available"
    }
    context.id = ID
    context.payload = payload
    result = petstore.post(payload)
    assert result.status_code == 200


@then('The pet is added')
def step_impl(context):
    result = petstore.get(context.id)
    assert result.status_code == 200
    pet = result.json()
    for key in context.payload:
        assert pet[key] == context.payload[key]


@when('I delete a pet')
def step_impl(context):
    result = petstore.delete(context.id)
    assert result.status_code == 200


@then('The pet is deleted')
def step_impl(context):
    result = petstore.get(context.id)
    assert result.status_code != 200
    assert result.json()['message'] == "Pet not found"
