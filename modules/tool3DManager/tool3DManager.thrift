#tool3DManager.thrift

/**
* tool3DManager_IDLServer
*
* Interface. 
*/

struct Vector{}
(
    yarp.name = "yarp::sig::Vector"
    yarp.includefile="yarp/sig/Vector.h"
)


service tool3DManager_IDLServer
{
    /**
     * Start the module
     * @return true/false on success/failure
     */
    bool start();

    /**
     * Quit the module
     * @return true/false on success/failure
     */
    bool quit();

    /**
     * Sets segmentation to 2D (true) or 3D (false)
     * @return true/false on success/failure to toggle segmentation method.
     */
    bool setSeg(1: bool seg = false);

    /****************************** TOOL LOADING AND INFORMATION **************************************/

    /**
     * Set the tool name on objects3DExplorer
     * @return true/false on success/failure on setting name
     */
    bool setToolName(1: string tool);

    /**
     * Performs the sequence to get the tool: \n
     * - On the simulator calls simtoolloader which creates the tool  <i>tool</i> at the orientation <i>deg</i>, tilted at <i>tilt</i> and with a displacement on the -Y hand axis <i>disp</i>. Uses magnet function to hold it to hand.
     * - Moreover, the tool end effector is located and attached to the kinematic chain with affMotor and shown on the viewer
     * - On the real robot moves hand to receiving position and closes hand on tool grasp. In this case  <i>tool</i>, <i>deg</i>, <i>disp</i>  and <i>tilt</i> should correspond to the way in which the tool is given
     * @return true/false on success/failure of loading the tool with correct pose
     */
    bool getToolByPose(1:string tool, 2:double deg = 0.0, 3:double disp = 0.0, 4:double tilt = 45.0,  5:double shift = 0.0);

    /**
     * Performs the sequence to get the tool: \n
     * - Grasp (through ARE)
     * - Load tool in objects3Dexplorer (by setToolName)
     * - Find pose and tooltip with align method (by findPose)
     * @return true/false on success/failure of grasping and loading the named tool
     */
    bool getTool(1:string tool);

    /**
     * Communicates with ARE and KM to grasp a tool and move it to the center.
     * @return true/false on success/failure
     */
    bool graspTool();

    /**
     * Communicates with O3DE to explore the tool and get the tooltip without a model
     * @return true/false on success/failure
     */
    bool explore();

    /**
     * Communicates with KM  move the tool to the center.
     * @return true/false on success/failure
     */
    bool lookTool();

    /**
     * Move tool in hand (sim) and change kinematic extension (sim and real).
     * @return true/false on success/failure of regrasping the tool
     */
    bool regrasp(1:double deg = 0.0, 2:double disp = 0.0, 3:double tilt = 45.0, 4:double shift = 0.0);

    /**
     * Start the methods to find the tool pose by aligning the partial reconstruction with a tool model: \n
     * @return true/false on success/failure of finding the tool pose
     */
    bool findPose();


    /**
     * Queries toolFeatExt module to extract the feaures of the loaded module \n
     * @return true/false on success/failure to extract features
     */
    bool getToolFeats();

    /**
     * Finds out the location of the object and returns its coordinates \n
     * @return Vector bottle with object coordinates in 3D X Y Z
     */
    Vector objLoc();

    /**
     * Finds out the rotation of the object and returns its rotation values \n
     * @return Vector bottle with object rotation
     */
    Vector objRot();

    /****************************** ACTIONS **************************************/

    /**
     * Adopt home position (optionally opens hands too)
     * @return true/false on success/failure
     */
    bool goHome(1:bool hands = false);

    /**
     * Calibrates the table height through ARE: \n
     * @param calib . True performs calibration, false gets stored data.
     * @returns true
     */
    bool findTable(1:bool calib = true);

    /**
     * Performs a slide action along the diameter of the circle of given radius and center on the object, from theta to -theta. \n
     * @return true/false on success/failure to do Action
     */
    bool slide(1:double thetha = 0.0, 2:double radius = 0.0);

    /**
     * Performs a drag action from the object in the direction indicated by theta and radius. \n
     * @return true/false on success/failure to do Action
     */
    bool drag(1:double thetha = 0.0, 2:double radius = 0.0,  3:double tilt = -15.0);

    /**
     * Performs a drag action from the given 3D coords in the direction indicated by theta and radius. \n
     * The trial consist on locating the object and executing the slide action
     * @return true/false on success/failure to do Action
     */
    bool drag3D(1:double x, 2:double y, 3:double z, 4:double thetha = 0.0, 5:double radius = 0.0,  6:double tilt = -15.0, 7:bool useTool = true);


    /**
     * (Re)Initializes object template for tracking. The user has to click on the upper left and lower right corners of the object to be tracked (in that order).\n
     * @return true/false on success/failure to set the template and (re)start tracking
     */
    bool trackObj();

    /**
     * Computes the effect of the action in terms of distance displaced, angle of displacement and rotation exerted on the object. \n
     * @return true/false on success/failure to compute Effect
     */
    bool compEff();

    /*********************** EXPERIMENT ROUTINES ************************************/

    /**
     * Runs numAct actions for numPoses times, each time with a random tool in a random pose
     * @return true/false on success/failure to perform all actions
     */
    bool runRandPoses(1: i32 numPoses, 2: i32 numAct = 8);

    /**
     * Runs numAct actions with the given tool on the given pose and computes the effect. \n
     * @return true/false on success/failure to perform all actions
     */
    bool runToolPose(1:string tool, 2: double deg = 0.0, 3: double disp = 0.0, 4: double tilt = 45.0, 5: i32 numAct = 8);

    /**
     * Runs numAct actions with the given tool on the given orientation, for the displacements {-2, 0, 2} and computes the effect. \n
     * @return true/false on success/failure to perform all actions
     */
    bool runToolOr(1:string tool, 2: double graspOr = 0.0, 3: i32 numAct = 8);

    /**
     * For the given tool, performs numAct actions for each toolpose. Tries all toolposes as combinations
     * of grasp orientation {-90, 0, 90} and displacements { -2, 0, 2} cm. \n
     * @return true/false on success/failure to perfomr all actions on all toolPoses
     */
    bool runToolTrial(1:string tool, 2: i32 numAct = 8);

    /**
     * Runs full trials for all tool with indices between toolini and toolEnd. \n
     * @return true/false on success/failure to perform all actions
     */
    bool runExp(1:string tool, 2: i32 toolEnd = 54);

    /**
     * Extracts OMS-EGI features from grasped tool and calls MATLAB to get the predicted effects of possible action
     * Then, chooses the best action for the given goal (1: maxDist, 2: Pull) \n
     * @return true/false on success/failure to query matlab and perform action
     */
    bool selectAction(1: i32 goal = 1);

    /**
     * Runs selectAction trials for all the test tools for given goal (1: maxDist, 2: Pull)
     * @return true/false on success/failure to perform actions selections
     */
    bool predExp(1: i32 goal = 1);

}
