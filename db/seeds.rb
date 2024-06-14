# Create jobs
job1 = Job.create!(
  title: "Software Engineer",
  description: "Develop and maintain software solutions."
)
job2 = Job.create!(
  title: "Product Manager",
  description: "Oversee the development and delivery of products."
)
job3 = Job.create!(
  title: "Designer",
  description: "Design user interfaces and experiences."
)

# Create job events
Job::Event::Activated.create!(job: job1)
Job::Event::Deactivated.create!(job: job2)
Job::Event::Activated.create!(job: job3)

# Create applications
application1 = Application.create!(
  candidate_name: "John Doe",
  job: job1
)
application2 = Application.create!(
  candidate_name: "Jane Smith",
  job: job1
)
application3 = Application.create!(
  candidate_name: "Alice Johnson",
  job: job3
)

# Create application events
Application::Event::Interview.create!(application: application1, data: { interview_date: '2023-01-15' })
Application::Event::Hired.create!(application: application1, data: { hire_date: '2023-02-01' })

Application::Event::Interview.create!(application: application2, data: { interview_date: '2023-01-20' })
Application::Event::Rejected.create!(application: application2)

Application::Event::Interview.create!(application: application3, data: { interview_date: '2023-01-25' })

# Create notes for applications
Application::Event::Note.create!(application: application1, data: { content: "Excellent coding skills." })
Application::Event::Note.create!(application: application2, data: { content: "Good communication skills." })
Application::Event::Note.create!(application: application3, data: { content: "Creative and detail-oriented." })

puts "Seed data created successfully!"
