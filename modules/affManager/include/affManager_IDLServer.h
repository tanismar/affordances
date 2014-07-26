// This is an automatically-generated file.
// It could get re-generated if the ALLOW_IDL_GENERATION flag is on.

#ifndef YARP_THRIFT_GENERATOR_affManager_IDLServer
#define YARP_THRIFT_GENERATOR_affManager_IDLServer

#include <yarp/os/Wire.h>
#include <yarp/os/idl/WireTypes.h>

class affManager_IDLServer;


/**
 * affManager_IDLServer
 * Interface.
 */
class affManager_IDLServer : public yarp::os::Wire {
public:
  affManager_IDLServer() { yarp().setOwner(*this); }
/**
 * Start the module
 * @return true/false on success/failure
 */
  virtual bool start();
/**
 * Adopt home position
 * @return true/false on success/failure
 */
  virtual bool goHome();
/**
 * Adopt home position while keeping hand pose
 * @return true/false on success/failure
 */
  virtual bool goHomeNoHands();
/**
 * performs the sequence to get the tool from user, look at it and extract its features.
 * @return true/false on success/failure of looking at that position
 */
  virtual bool getTool();
/**
 * Allows the user to define a label for the tool configuration to deal with
 * @return true/false on success/failure of looking at that position
 */
  virtual bool setTool(const std::string& tpName = "undef");
/**
 * Asks for tool and move the arm to receiving position
 * @return true/false on success/failure on going to receive position
 */
  virtual bool askForTool();
/**
 * Closes hand on tool previously reached or received.
 * @return true/false on success/failure on holding the tool.
 */
  virtual bool graspTool();
/**
 * Moves the tool in hand to a comfortable lookable position, i.e., in front of iCubs eyes
 * @return true/false on success/failure of bringing the tool in front
 */
  virtual bool lookAtTool();
/**
 * Gets user object box and learns it for tracking
 * @return true/false on success/failure of finding/looking at object
 */
  virtual bool trackObj();
/**
 * Look and locate in 3D the target object
 * @return true/false on success/failure of finding/looking at object
 */
  virtual bool locateObj();
/**
 * Finds tool in hand and observes it extracting features)
 * @return true/false on success/failure finding and extracting feats from tool
 */
  virtual bool observeTool();
/**
 * Uses active exploration and non-linear optimization to copmute the tool dimensions and attach its end-effector to the robot's arm.
 * Makes use of KarmaMotor, KarmaToolProjection and KarmaToolFinder
 * @return true/false on success/failure
 * to select
 */
  virtual bool attachTool();
/**
 * Executes the sequence to clear the visual field, look at the object, perform the action and observe the effect.
 * @return true/false on success/failure
 * to select
 */
  virtual bool doAction();
/**
 * Performs the drawing action a given number of times to learn the mapping
 * @return true/false on success/failure
 * to select
 */
  virtual bool trainDraw();
/**
 * Performs once the whole routine of looking at the tool getting its features ad then performing an action, getting also parameters and effect of the action
 * @return true/false on success/failure
 * to select
 */
  virtual bool observeAndDo();
/**
 * Executes a sliding action (push or draw) using the end-effector (tool or hand)
 * @return true/false on success/failure
 * to select
 */
  virtual bool slideAction();
/**
 * Computes the effect of the action as the difference in the position of the object before and after the slide action.
 * @return true/false on success/failure
 * to select
 */
  virtual bool computeEffect();
/**
 * Quit the module
 * @return true/false on success/failure
 */
  virtual bool quit();
  virtual bool read(yarp::os::ConnectionReader& connection);
  virtual std::vector<std::string> help(const std::string& functionName="--all");
};

#endif

