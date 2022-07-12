using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlightController : MonoBehaviour
{

    public GameObject player;

    void Start()
    {
    }
    void Update()
    {
        if (player.transform.position == transform.position) return;
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");
        if (horizontal >0 && vertical > 0) transform.eulerAngles = new Vector3(0, 0, -45);
        else if (horizontal > 0 && vertical < 0) transform.eulerAngles = new Vector3(0, 0, -135);
        else if (horizontal < 0 && vertical > 0) transform.eulerAngles = new Vector3(0, 0, 45);
        else if (horizontal < 0 && vertical < 0) transform.eulerAngles = new Vector3(0, 0, 135);
        else if (horizontal > 0) transform.eulerAngles = new Vector3(0, 0, 270);
        else if (horizontal < 0) transform.eulerAngles = new Vector3(0, 0, 90);
        else if (vertical > 0) transform.eulerAngles = new Vector3(0, 0, 0);
        else if (vertical < 0) transform.eulerAngles = new Vector3(0, 0, 180);
        transform.position = player.transform.position;
    }
}
