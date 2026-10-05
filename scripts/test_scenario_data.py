"""Regression tests for the data defects found in the October manuscript review."""

from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from scenario_data import load_reserve_paths, load_planning_weights

ROOT = Path(__file__).resolve().parents[1]


class ScenarioDataTests(unittest.TestCase):
    def setUp(self):
        self.temp = TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name) / "input.csv"

    def reserve(self, before=None, after=None):
        src = (ROOT / "data/sources/dollar_reserves_projection.csv").read_text()
        self.path.write_text(src.replace(before, after) if before else src)
        return load_reserve_paths(self.path)

    def planning(self, before=None, after=None):
        src = (ROOT / "data/sources/scenario_planning_weights.csv").read_text()
        self.path.write_text(src.replace(before, after) if before else src)
        return load_planning_weights(self.path)

    def test_current_inputs(self):
        self.assertEqual(self.reserve()[0]["USD_Observed"], 56.92)
        self.assertEqual(sum(r["Planning_Weight"] for r in self.planning()), 100)

    def test_forecast_must_share_observed_anchor(self):
        with self.assertRaisesRegex(ValueError, "start at the observed"):
            self.reserve("56.92,56.92,56.92,56.92", "56.92,58.0,56.92,56.92")

    def test_future_value_cannot_be_marked_observed(self):
        with self.assertRaisesRegex(ValueError, "only the first"):
            self.reserve("2030,2030,,", "2030,2030,56.5,")

    def test_percentages_and_years_must_be_finite(self):
        for before, after in [("56.5", "nan"), ("56.5", "101"), ("2030,", "nan,")]:
            with self.subTest(after=after), self.assertRaises(ValueError):
                self.reserve(before, after)

    def test_years_cannot_repeat(self):
        with self.assertRaisesRegex(ValueError, "increase strictly"):
            self.reserve("2030,2030", "2025.75,2030")

    def test_shaded_bounds_must_agree_with_path_order(self):
        with self.assertRaisesRegex(ValueError, "path ordering"):
            self.reserve("56.5,54.0,50.0", "56.5,54.0,60.0")

    def test_weight_total_and_scenario_identity(self):
        for before, after in [("0.76,40", "0.76,45"), ("D,Renewed", "A,Renewed")]:
            with self.subTest(after=after), self.assertRaises(ValueError):
                self.planning(before, after)

    def test_quadrant_mismatch(self):
        with self.assertRaisesRegex(ValueError, "outside its stated quadrant"):
            self.planning("0.28,0.32", "0.28,0.82")


if __name__ == "__main__":
    unittest.main()
