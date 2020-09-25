import subprocess
import time
import signal


try:

    autoware_path = '/home/takano/autoware.ai'

    tf_out_file = open('log/tf_out.log', 'w')
    tf_err_file = open('log/tf_err.log', 'w')
    tf_loader = subprocess.Popen('. ' + autoware_path + '/install/setup.sh; roslaunch tf/tf.launch', shell=True, stdout=tf_out_file, stderr=tf_err_file)

    points_map_loader_out_file = open('log/points_map_loader_out.log', 'w')
    points_map_loader_err_file = open('log/points_map_loader_err.log', 'w')
    point_map_loader = subprocess.Popen('. ' + autoware_path + '/install/setup.sh; rosrun map_file points_map_loader noupdate pointcloud_map/0.2-bin/*.pcd', shell=True, stdout=points_map_loader_out_file, stderr=points_map_loader_err_file)

    vector_map_loader_out_file = open('log/vector_map_loader_out.log', 'w')
    vector_map_loader_err_file = open('log/vector_map_loader_err.log', 'w')
    vector_map_loader = subprocess.Popen('. ' + autoware_path + '/install/setup.sh; rosrun map_file vector_map_loader vector_map/Ver1.20/*.csv', shell=True, stdout=vector_map_loader_out_file, stderr=vector_map_loader_err_file)

  #  input('twist_filterノードを起動し、Enterを押してください。')




#pure_pursuitの入力ここから
    rosbag_play = subprocess.Popen(['rosbag', 'play', 'pure_pursuit_topics.bag', '/twist_raw:=/twist_raw_test', '/ctrl_cmd:=/ctrl_cmd_test', '/next_waypoint_mark:=/next_waypoint_mark_test', '/next_target_mark:=/next_target_mark_test', '/search_circle_mark:=/search_circle_mark_test', '/line_point_mark:=/line_point_mark_test', '/trajectory_circle_mark:=/trajectory_circle_mark_test'], stdin=subprocess.DEVNULL)
#pure_pursuitの入力ここまで

#pure_pursuitの出力ここから

    twist_raw_test_file = open('result/twist_raw_test', 'w')
    dump_twist_raw_test = subprocess.Popen(['rostopic', 'echo', '/twist_raw_test', '-p'], stdout=twist_raw_test_file)

    twist_raw_file = open('result/twist_raw', 'w')
    dump_twist_raw = subprocess.Popen(['rostopic', 'echo', '/twist_raw', '-p'], stdout=twist_raw_file)

    ctrl_cmd_test_file = open('result/ctrl_cmd_test', 'w')
    dump_ctrl_cmd_test = subprocess.Popen(['rostopic', 'echo', '/ctrl_cmd_test', '-p'], stdout=ctrl_cmd_test_file)

    ctrl_cmd_file = open('result/ctrl_cmd', 'w')
    dump_ctrl_cmd = subprocess.Popen(['rostopic', 'echo', '/ctrl_cmd', '-p'], stdout=ctrl_cmd_file)

    next_waypoint_mark_test_file = open('result/next_waypoint_mark_test', 'w')
    dump_next_waypoint_mark_test = subprocess.Popen(['rostopic', 'echo', '/next_waypoint_mark_test', '-p'], stdout=next_waypoint_mark_test_file)

    next_waypoint_mark_file = open('result/next_waypoint_mark', 'w')
    dump_next_waypoint_mark = subprocess.Popen(['rostopic', 'echo', '/next_waypoint_mark', '-p'], stdout=next_waypoint_mark_file)

    next_target_mark_test_file = open('result/next_target_mark_test', 'w')
    dump_next_target_mark_test = subprocess.Popen(['rostopic', 'echo', '/next_target_mark_test', '-p'], stdout=next_target_mark_test_file)

    next_target_mark_file = open('result/next_target_mark', 'w')
    dump_next_target_mark = subprocess.Popen(['rostopic', 'echo', '/next_target_mark', '-p'], stdout=next_target_mark_file)

    search_circle_mark_test_file = open('result/search_circle_mark_test', 'w')
    dump_search_circle_mark_test = subprocess.Popen(['rostopic', 'echo', '/search_circle_mark_test', '-p'], stdout=search_circle_mark_test_file)

    search_circle_mark_file = open('result/search_circle_mark', 'w')
    dump_search_circle_mark = subprocess.Popen(['rostopic', 'echo', '/search_circle_mark', '-p'], stdout=search_circle_mark_file)

    line_point_mark_test_file = open('result/line_point_mark_test', 'w')
    dump_line_point_mark_test = subprocess.Popen(['rostopic', 'echo', '/line_point_mark_test', '-p'], stdout=line_point_mark_test_file)

    line_point_mark_file = open('result/line_point_mark', 'w')
    dump_line_point_mark = subprocess.Popen(['rostopic', 'echo', '/line_point_mark', '-p'], stdout=line_point_mark_file)

    trajectory_circle_mark_test_file = open('result/trajectory_circle_mark_test', 'w')
    dump_trajectory_circle_mark_test = subprocess.Popen(['rostopic', 'echo', '/trajectory_circle_mark_test', '-p'], stdout=trajectory_circle_mark_test_file)

    trajectory_circle_mark_file = open('result/trajectory_circle_mark', 'w')
    dump_trajectory_circle_mark = subprocess.Popen(['rostopic', 'echo', '/trajectory_circle_mark', '-p'], stdout=trajectory_circle_mark_file)

#pure_pursuitの出力ここまで





    rosbag_play.wait()

except KeyboardInterrupt:
    rosbag_play.send_signal(signal.SIGINT)
    rosbag_play.wait()

finally:
    time.sleep(1)



#pure_pursuit

dump_twist_raw_test.send_signal(signal.SIGINT)
dump_twist_raw_test.wait()
twist_raw_test_file.close()

dump_twist_raw.send_signal(signal.SIGINT)
dump_twist_raw.wait()
twist_raw_file.close()

dump_ctrl_cmd_test.send_signal(signal.SIGINT)
dump_ctrl_cmd_test.wait()
ctrl_cmd_test_file.close()

dump_ctrl_cmd.send_signal(signal.SIGINT)
dump_ctrl_cmd.wait()
ctrl_cmd_file.close()

dump_next_waypoint_mark_test.send_signal(signal.SIGINT)
dump_next_waypoint_mark_test.wait()
next_waypoint_mark_test_file.close()

dump_next_waypoint_mark.send_signal(signal.SIGINT)
dump_next_waypoint_mark.wait()
next_waypoint_mark_file.close()

dump_next_target_mark_test.send_signal(signal.SIGINT)
dump_next_target_mark_test.wait()
next_target_mark_test_file.close()

dump_next_target_mark.send_signal(signal.SIGINT)
dump_next_target_mark.wait()
next_target_mark_file.close()

dump_search_circle_mark_test.send_signal(signal.SIGINT)
dump_search_circle_mark_test.wait()
search_circle_mark_test_file.close()

dump_search_circle_mark.send_signal(signal.SIGINT)
dump_search_circle_mark.wait()
search_circle_mark_file.close()

dump_line_point_mark_test.send_signal(signal.SIGINT)
dump_line_point_mark_test.wait()
line_point_mark_test_file.close()

dump_line_point_mark.send_signal(signal.SIGINT)
dump_line_point_mark.wait()
line_point_mark_file.close()

dump_trajectory_circle_mark_test.send_signal(signal.SIGINT)
dump_trajectory_circle_mark_test.wait()
trajectory_circle_mark_test_file.close()

dump_trajectory_circle_mark.send_signal(signal.SIGINT)
dump_trajectory_circle_mark.wait()
trajectory_circle_mark_file.close()

#pure_pursuit














