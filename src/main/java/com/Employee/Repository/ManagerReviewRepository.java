package com.Employee.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Employee.Entites.ManagerReview;

@Repository
public interface ManagerReviewRepository extends JpaRepository<ManagerReview, Long> {
	List<ManagerReview> findByEmployeeId(Long employeeId);
}