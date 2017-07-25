import unittest
from example import app, db

TEST_SQLALCHEMY_DATABASE_URI = "sqlite:///test.db"

class appTestCase(unittest.TestCase):
	def setUp(self):
		self.app = app.test_client()
		app.config["TESTING"] = True

		app.config["SQLALCHEMY_DATABASE_URI"] = TEST_SQLALCHEMY_DATABASE_URI
		db.create_all()
		db.session.commit()

	def tearDown(self):
		db.session.remove()
		db.drop_all()

	def test_get_tasks(self):

		response = self.app.get("/api/v0.1/tasks")
		
		self.assertEqual(200, response.status_code)
		
if __name__ == '__main__':
    unittest.main()