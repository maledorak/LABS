import datetime

from rescuetime_widget import is_focustime_active


def get_now():
    return datetime.datetime.now(datetime.timezone.utc)

def get_past_time(minutes):
    return get_now() - datetime.timedelta(minutes=minutes)



class TestIsFocustimeActiveWhenNoEndedRecords:
    def test_when_no_started_records(self):
        assert is_focustime_active([], []) == (False, 0)

    def test_when_one_started_and_finished_naturally(self):
        now = get_now()
        time_30_min_ago = get_past_time(30)
        # import pdb; pdb.set_trace()
        started = [
            # {"created_at": }
        ]
        assert is_focustime_active([], []) == (False, 0)

# def test_is_focustime_active_when_no_started_and_ended_records():

# def test_is_focustime_active_when_one_started():
    # assert is_focustime_active([], []) == (False, 0)
