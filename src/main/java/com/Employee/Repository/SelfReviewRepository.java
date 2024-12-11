package com.Employee.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Employee.Entites.SelfReview;

@Repository
public interface SelfReviewRepository extends JpaRepository<SelfReview, Long> {
	List<SelfReview> findByEmployeeId(Long employeeId);
}