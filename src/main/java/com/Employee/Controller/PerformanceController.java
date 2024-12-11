package com.Employee.Controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Employee.Services.PerformanceService;

@RestController
@RequestMapping("/api/performances")
public class PerformanceController {

	private final PerformanceService performanceService;

	@Autowired
	public PerformanceController(PerformanceService performanceService) {
		this.performanceService = performanceService;
	}

	// Get Performance Summary 
	@GetMapping("/{employeeId}")
	public ResponseEntity<?> getPerformanceSummary(@PathVariable Long employeeId) {
		return ResponseEntity.ok(performanceService.getPerformanceSummary(employeeId));
	}

	// Step 1: Employee submits self-review and self-rating
	@PostMapping("/self-review/{employeeId}")
	public ResponseEntity<?> submitSelfReview(@PathVariable Long employeeId,
			@RequestBody Map<String, Object> reviewData) {
		
		boolean isSubmitted = performanceService.isSelfReviewSubmitted(employeeId);
		if (isSubmitted) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("Self-review already submitted for this employee.");
		}

		return performanceService.submitSelfReview(employeeId, reviewData);
	}

	// Step 2: Manager submits review after employee self-review
	@PostMapping("/manager-review/{employeeId}")
	public ResponseEntity<?> submitManagerReview(@PathVariable Long employeeId,
			@RequestBody Map<String, Object> reviewData) {
		boolean isSelfReviewSubmitted = performanceService.isSelfReviewSubmitted(employeeId);
		if (!isSelfReviewSubmitted) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("Employee must submit self-review before manager review.");
		}

		return performanceService.submitManagerReview(employeeId, reviewData);
	}
}
