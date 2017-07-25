import unittest  
from example import app

class appTestCase(unittest.TestCase):  
    def setUp(self):
        self.app = app.test_client()
        app.config["TESTING"] = True

    def tearDown(self):
        pass

    def test_get_tasks(self):
        response = self.app.get("/api/v0.1/tasks")
        self.assertEqual(200, response.status_code)

if __name__ == '__main__':  
    unittest.main()
