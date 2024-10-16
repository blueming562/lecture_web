package lectHakbu;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Classes;
import Model.Course;
import Model.Department;
import cart_list.CartDAO;
import lecture_list.ClassDAO;
import lecture_list.CourseDAO;
import lecture_list.DepartmentDAO;
import lecture_list.EnrollmentDAO;
import wish_list.WishlistDAO;

@WebServlet("/lectHakbu")
public class lectHakbuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private CourseDAO courseDAO;
    private ClassDAO classDAO;
    private EnrollmentDAO enrollmentDAO;
    private DepartmentDAO departmentDAO;
    private CartDAO cartDAO;
    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        classDAO = new ClassDAO();
        enrollmentDAO = new EnrollmentDAO();
        departmentDAO = new DepartmentDAO();
        cartDAO = new CartDAO();
        wishlistDAO = new WishlistDAO();
    }
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션에서 student_id 가져오기 (로그인 구현 필요)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student_id") == null) {
            // 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (int) session.getAttribute("student_id");

        // 모든 강의 목록 조회
        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("allCourses", courses);//jsp의 allCourses 파라미터로 getAllCourse한 값을 전달
        

        // 모든 클래스 조회
        List<Classes> allClasses = classDAO.getAllClasses(studentId);
        request.setAttribute("allClasses", allClasses);
        
        // 모든 학과 조회 및 맵 생성
        List<Department> departments = departmentDAO.getAllDepartments();
        Map<Integer, String> departmentsMap = new HashMap<>();
        for (Department dept : departments) {
            departmentsMap.put(dept.getDepartmentId(), dept.getDepartmentName());
        }
        request.setAttribute("departmentsMap", departmentsMap);
        
        
        request.getRequestDispatcher("WEB-INF/views/lecture/lectHakbu.jsp").forward(request, response);
	}
}
