# SECP3623-DATABASE-PROGRAMMING

# 🚀 Database Programming (SECP3623-02) - Learning Portfolio & Project Reflection

Welcome to my learning portfolio and project reflection repository for the **Database Programming (SECP3623)** course.

---

## 📑 Overall Course Reflection

The Database Programming (SECP3623) course has been a massive paradigm shift in how I view data design, management, and optimization. This course not only solidified my conventional SQL skills but also exposed me to dynamic NoSQL database architectures through MongoDB.

Key takeaways I gained throughout this course include:
* **The Transition from Relational to Document-Oriented Architecture:** Understanding the stark contrast between the rigid schema integrity of MySQL and the flexible, scalable JSON-based document management in MongoDB. This shift in mindset allows me to choose the right database design patterns based on real-world application requirements.
* **Query Performance Tuning & Optimization:** I learned that building a working database is simply not enough. Through execution plan analysis (`EXPLAIN`) and profiling, I discovered how proper indexing (B-Tree and Single-Field/Compound Indexes) can drastically reduce data retrieval costs for high-throughput systems.
* **Concurrency and Robust Transaction Control:** Handling core transaction management concepts (ACID properties, locking mechanisms, and isolation levels) taught me the importance of designing safe databases that remain resilient against data anomalies when accessed by thousands of concurrent users.

---

## 🛠️ Assignment & Lab Reflection

### 🔹 [Assignment 1: Database Creation and Integrity Constraints (MySQL)]
* **Concepts Focused:** Data Definition Language (DDL), Data Manipulation Language (DML), Referential Integrity Constraints (PK, FK, `ON DELETE RESTRICT`, `ON UPDATE CASCADE`), `CHECK` constraints, Advanced Joins, and SQL Built-in Functions (`ROUND`, `UPPER`, `CONCAT`, `CASE`).
* **Implementation Details:** Designed and developed a hostel accommodation management database (`hostel_mgmt_sf`) encompassing 5 interconnected tables: `room_types`, `rooms`, `students`, `maintenance`, and `payments`.
* **Reflection:** This assignment reinforced my understanding of preserving data integrity. Meticulous Foreign Key (FK) constraints design ensured no orphan data could exist within the system. I also learned how to combine advanced filtering clauses like `HAVING` with `GROUP BY` to generate precise analytical reports for room maintenance issues across different floor levels.

### 🔹 [Assignment 2: Transaction Management]
* **Concepts Focused:** Transaction States, Concurrency Control, Lock Types (Shared `lock_s` vs. Exclusive `lock_x`), Strict 2-Phase Locking (2PL), Conflict Serializability, and Deadlock Analysis.
* **Implementation Details:** Analyzed non-serial schedules, constructed precedence graphs to detect serialization cycles, and resolved data conflict scenarios using robust database locking mechanisms.
* **Reflection:** This heavily theoretical assignment opened my eyes to the structural risks behind concurrent database transactions. Learning to detect deadlocks and starvation via precedence graphs taught me defensive programming patterns. This ensures that database transaction workflows remain perfectly consistent even when facing unexpected hardware failures or mid-operation interruptions.

### 🔹 [Lab 1: Indexes Execution & Profiling (MySQL)]
* **Concepts Focused:** B-Tree Indexing mechanism, Range Queries performance, Query Profiling (`SET profiling = 1`), and Query Execution Plan Analysis (`EXPLAIN`).
* **Implementation Details:** Conducted comparative execution time tests on an `employee` table before and after implementing B-Tree indexes for attributes involving range queries (such as `salary` and `join_date`).
* **Reflection:** This lab practically validated database indexing theories. Through `SHOW PROFILES`, I witnessed firsthand how expensive Full Table Scan costs can be drastically reduced by switching to index-based lookups. Understanding how B-Tree structures sort data in a balanced manner gave me an excellent toolkit for maximizing external application performance.

### 🔹 [Lab 2: NoSQL Clinic Management System (MongoDB)]
* **Concepts Focused:** Document Data Model, Collection creation, CRUD operations via Mongosh (`insertMany`, `find`, `updateMany`, `deleteMany`), Projection filtering, Aggregation Framework (`$group`, `$sum`, `$sort`), and Query Array Tracking.
* **Implementation Details:** Built a clinic management database (`clinicdb`) containing `appointments` and `loginSessions` collections. Implemented query reporting for patient appointments based on fee ranges, active staff sessions, and total medical department revenue calculations.
* **Reflection:** This lab was my gateway to NoSQL databases using JSON-like documents. The absence of a rigid table structure provides absolute freedom to store nested arrays. I was particularly impressed by the sheer power of the `$group` operator within MongoDB’s aggregation pipelines, which proved to be far more modular and expressive for statistical summaries than traditional SQL aggregate functions.

---

## 📦 Final Group Project Reflection: "Delivery Records System"

### 📄 [Phase 1: Relational Architecture Design (Attendance System Domain)]
* **Concepts Covered:** Conceptual Database Design, Entity-Relationship Diagram (ERD) mapping, DDL/DML script orchestration, Subqueries, Complex Multi-table Joins, and MySQL Optimizations.
* **Core Design:** Designed a lecture attendance management system (`attendance_system`) by mapping core entities: `students`, `lecturers`, `courses`, `enrollments`, `class_sessions`, and `attendance_records`.
* **Reflection:** Phase 1 emphasized the absolute necessity of data normalization before executing physical database implementation. We learned to arrange DDL scripts according to foreign key dependency hierarchies to ensure seamless table generation without constraint conflicts. Successfully linking student attendance data through Self-Joins and Correlated Subqueries validated the logical integrity of our initial ERD design.

### 💾 [Phase 2: NoSQL Document Model & Backend Scale (MongoDB System)]
* **Concepts Covered:** Document Data Model Design, Embedding vs. Referencing strategies, Hybrid Schemas, Document Snapshotting, Compound Indexing, Multi-Stage Aggregation Pipelines (`$match`, `$group`, `$sort`), and Security Controls (NoSQL Injection mitigation).
* **Core Design:** Built a courier logistics automation system managing four primary collections: `customers` (storing profiles and embedded address arrays), `orders` (utilizing embedded product snapshots to maintain data locality), `drivers` (tracking ratings and vehicle assignments), and `deliveries` (real-time logistics logs referencing Customer and Driver IDs).
* **Reflection:** The final phase of the project offered the most valuable exposure to modern, scalable data management. We challenged ourselves by combining two major NoSQL modeling strategies: **Embedding** (to maintain data locality and avoid expensive joins on customer addresses and product details) and **Referencing** (to link delivery records to drivers without duplicating core master data). Writing complex multi-stage aggregation pipelines to calculate average delivery fees and creating compound indexes to optimize historical order searches fully validated NoSQL's scalability in real-world logistics management.
