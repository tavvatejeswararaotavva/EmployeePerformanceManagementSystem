package com.Employee.Services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.Employee.Entites.Employee;
import com.Employee.Entites.ManagerReview;
import com.Employee.Entites.SelfReview;
import com.Employee.Repository.EmployeeRepository;
import com.Employee.Repository.ManagerReviewRepository;
import com.Employee.Repository.SelfReviewRepository;

@Service
public class PerformanceService {

	private final EmployeeRepository employeeRepository;
	private final SelfReviewRepository selfReviewRepository;
	private final ManagerReviewRepository managerReviewRepository;

	@Autowired
	public PerformanceService(SelfReviewRepository selfReviewRepository,
			ManagerReviewRepository managerReviewRepository, EmployeeRepository employeeRepository) {
		this.selfReviewRepository = selfReviewRepository;
		this.managerReviewRepository = managerReviewRepository;
		this.employeeRepository = employeeRepository;
	}

	// Step 1: Employee submits self-review and self-rating
	public ResponseEntity<?> submitSelfReview(Long employeeId, Map<String, Object> reviewData) {
		
		Employee employee = employeeRepository.findById(employeeId)
				.orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Employee not found"));

		// Check if self-review already exists for this employee
		List<SelfReview> existingSelfReviews = selfReviewRepository.findByEmployeeId(employeeId);
		if (!existingSelfReviews.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("Self-review already submitted for this employee.");
		}

		String selfReviewText = (String) reviewData.get("selfReviewText");
		Integer selfRating = (Integer) reviewData.get("selfRating"); // Can be null

		
		SelfReview selfReview = new SelfReview();
		selfReview.setEmployee(employee);
		selfReview.setReviewText(selfReviewText);
		selfReview.setSelfRating(selfRating); 
		selfReviewRepository.save(selfReview);

		return ResponseEntity.status(HttpStatus.CREATED).body("Self-review submitted successfully.");
	}

	// Step 2: Manager submits review after employee self-review
	public ResponseEntity<?> submitManagerReview(Long employeeId, Map<String, Object> reviewData) {
		// Validate employee exists
		Employee employee = employeeRepository.findById(employeeId)
				.orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Employee not found"));

		
		List<SelfReview> selfReviews = selfReviewRepository.findByEmployeeId(employeeId);
		if (selfReviews.isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("Employee must submit self-review before manager review.");
		}

		
		String managerReviewText = (String) reviewData.get("managerReviewText");
		Integer managerRating = (Integer) reviewData.get("managerRating");

		
		ManagerReview managerReview = new ManagerReview();
		managerReview.setEmployee(employee);
		managerReview.setReviewText(managerReviewText);
		managerReview.setRating(managerRating);
		managerReviewRepository.save(managerReview);

		return ResponseEntity.status(HttpStatus.CREATED).body("Manager review submitted successfully.");
	}

	
	public Map<String, Object> getPerformanceSummary(Long employeeId) {
		List<SelfReview> selfReviews = selfReviewRepository.findByEmployeeId(employeeId);
		List<ManagerReview> managerReviews = managerReviewRepository.findByEmployeeId(employeeId);

		if (selfReviews.isEmpty() || managerReviews.isEmpty()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Reviews not found for employee ID: " + employeeId);
		}

		SelfReview selfReview = selfReviews.get(0);
		ManagerReview managerReview = managerReviews.get(0); 

		// Calculate self-review score based on the review text length 
		double selfReviewScore = selfReview.getReviewText().length() / 100.0;
		double finalScore = (selfReviewScore * 0.3) + (managerReview.getRating() * 0.7); 
																							// rating

		
		Map<String, Object> summary = new HashMap<>();
		summary.put("employee", employeeRepository.findById(employeeId).orElseThrow());
		summary.put("selfReview", selfReview);
		summary.put("managerReview", managerReview);
		summary.put("finalScore", finalScore);

		return summary;
	}

	
	public boolean isSelfReviewSubmitted(Long employeeId) {
		List<SelfReview> selfReviews = selfReviewRepository.findByEmployeeId(employeeId);
		return !selfReviews.isEmpty();
	}
}
