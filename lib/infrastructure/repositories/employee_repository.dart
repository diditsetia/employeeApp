abstract class EmployeeRepository {
  Future getEmployee();

  Future detailEmployee(
    String id,
  );

  Future createEmployee(
    file,
    String fristname,
    String lastname,
    String work,
    String telephone,
    String email,
    String site,
  );
}
