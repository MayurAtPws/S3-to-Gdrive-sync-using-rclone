# Cloning Data from S3 bucket to Google Drive using Rclone

## Specifications
- OS : Amazon Linux 2023
- Package manager : DNF


## Steps

### Installing RCLONE

- Download Rclone from https://rclone.org/downloads/

- Copy the `.rpm` package link 

- Download Rclone 

        curl -o rclone.rpm https://downloads.rclone.org/v1.65.2/rclone-v1.65.2-linux-amd64.rpm

- Install Rclone

         dnf install ./rclone.rpm -y


### Configuring RCLONE for Google Drive 

Official Docs : https://rclone.org/drive/

- run `rclone config`

        rclone config

- add a new remote `n`

- name your remote `gdrive`

- choose google drive `18`

- You cave the CLIENT ID and CLIENT SECRET Blank and Enter

- specify Scope of Rclone access to gdrive , `1` to give full read write access

- Service Account Credentials JSON file path. Leave it as EMPTY and ENTER . Click `N` to open advance config

- Press `N` for web browser to automatically authenticate rclone with remote. because you need a Web broswer for it . As we are using Headless remote server press `N`


  / Now Continue the procedure in your local machine with a browser /


⚠️ Note : As we are workin in a headless server. Rclone requires a machine with a Browser and Rclone installed to connect with Google drive

➡️ We Will use our Local Machine To connect with Google drive and then we Authorize our Remote Machine 

### Setting our Local Machine for Rclone auth with Gdrive

Installation Docs for all OS : https://rclone.org/install/#windows-chocolatey

- install Rclone for windows 

        winget install Rclone.Rclone

- Copy the command provided by your remote machine 

        # it looks like this
        rclone authorize "drive" "xxxxxxxxxxxxxx"

- It will open your Web Broswer and You click to Authorize it.

### back to remote machine 

  //# Now Continue the procedure in your remote machine  #//

- Now Copy the Response you get on your Local machine to your Remote Machine 

- Select whether u want to use this as Team Shared drive `n`

- Keep this gdrive `y`

- Now everything Configured For Gdrive

- `q`


### Configuring RCLONE for AWS S3

Official Docs : https://rclone.org/s3/#configuration


- run `rclone config`

        rclone config

- add a new remote `n`

- name your remote `s3bucket`

- choose storage type option as s3 `5` or `s3`

- choose amazon s3 option `1`

- Enter a Way to get the Auth for s3 (i am using Acess Keys  so using `1` and Enter your Access keys)

- If you choose IAM based auth make sure to give access to the role attached to your instance

- Enter your Region `us-east-1`

- choose Region endpoint leave it BLANK and ENTER

- Choose the Location Contraint from the option `1` (for us-east-1, choose according to your need)

- choose the ACL level `1`

- Choose the type of server side encryption used in S3 . I have used S3 managed key so i'm using `2` (AES256)

- choose your kms key for s3 bucket from your account

- Choose your Storage Class to store the new Objects in

- Edit advance config ? `n`

- Review and Save it `y`

- `q`

## Copying from s3 Bucket to Google Drive

- Rclone copy S3 -> google drive

        rclone copy s3bucket:bucket/path gdrive:folder

        #our Example
        rclone copy s3bucket:testbucketunimportant/ gdrive:/testbucketunimportant

- If u want to copy to a **shared Google Drive**

        rclone copy s3bucket:bucket/path gdrive:folder --drive-shared-with-me

- use `-v` to see the copying status and `--progress` to see Progress

- This will clone the entire S3 Bucket to that Folder. You can also specify a Partiular Folder.


## Testing 

- under [./test/gen.sh](./test/gen.sh)

- Give enough permission and Run it 

        chmod +x ./gen.sh

        ./gen.sh 

- The directories will be created u can use AWS CLI or directly drag and drop


